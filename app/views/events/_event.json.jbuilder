# frozen_string_literal: true

json.extract! event, :id, :user_id, :title_string, :body, :start, :end, :created_at, :updated_at
json.url event_url(event, format: :json)
