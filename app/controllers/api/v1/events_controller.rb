require "#{Rails.root}/app/controllers/application_controller.rb"

module Api
  module V1
    class EventsController < ApplicationController
    #  load_and_authorize_resource
      # CSRF対策
      protect_from_forgery except: [:create, :update]
      require 'open-uri'
      require 'cgi'
      require 'json'

      def index
        @events = Event.order(:id).limit(params[:limit]).offset(params[:offset]).to_a
        api_key = "AIzaSyB-7uQdd7ffahHDIS48WdDVN3U8Nw9us6I"
        calendarId = 'ja.japanese#holiday@group.v.calendar.google.com'
        uri = "https://www.googleapis.com/calendar/v3/calendars/#{CGI.escape(calendarId)}/events?orderBy=startTime&singleEvents=true&timeZone=Asia%2FTokyo&timeMin=#{CGI.escape(Time.now.iso8601)}&key=#{api_key}"
        today = (today || Date.today)
        json = open(uri).read
        JSON.parse(json)['items'].each do |item|
          holiday = Date.parse(item['start']['dateTime'] || item['start']['date'])
          @events.push(Event.new(title: item['summary'], start: holiday, end: holiday, user_id: current_user.id))
        end

        json = @events
        render json: json.to_json
      end

      def show
        @event = Event.find(params[:id])
        render json: @event.to_json
      end

      def edit
        @event = Event.find(params[:id])
      end

      def update
        @event = Event.find(params[:id])
        event_params.require(:title)
        event_params.require(:start)
        event_params.require(:end)
        respond_to do |format|
          format.any
          if @event.update!(event_params)
            @event.save
            render json: @event.to_json
          else
            render json: {status: "ng", code: 500, content: {message: "エラーです"}}
          end
        end
      end

      def new
        @event = Event.new
      end

      def create
        event_params.require(:title)
        event_params.require(:start)
        event_params.require(:end)
        @event = Event.new(event_params)
        @event.user_id = current_user.id
        respond_to do |format|
          format.any
          if @event.save!
            render json: @event
          else
            render json: {status: "ng", code: 500, content: {message: "エラーです"}}
          end
        end
      end

      def destroy
        @event = Event.find(params[:id])
        @event.destroy
        render json: @event
      end

      private
        def event_params
          params[:event]
          .permit(
            :title,
            :start,
            :end,
            :color,
            :allday
          )
        end
    end
  end
end