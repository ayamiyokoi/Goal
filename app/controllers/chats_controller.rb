# frozen_string_literal: true

class ChatsController < ApplicationController
  before_action :set_group, only: %i[ index create destroy ]
 #TODO: @chats省略で大丈夫か？
  def index
    @chat = Chat.new
    # @chats = @group.chats
  end

  def create
    @chat = @group.chats.build(chat_params)
    @chat.user_id = current_user.id
    unless @chat.save
      render 'error'
    end
    # @chats = @group.chats
  end

  # def update
  #   @chat.update(chat_params)
  # end

  def destroy
    @chats = Chat.find_by(id: params[:id], group_id: params[:group_id]).destroy
    # @chats = @group.chats
  end

  private
    def set_group
      @group = Group.find(params[:group_id])
      @chats = @group.chats.includes(:user)
    end

    def chat_params
      params.require(:chat).permit(:chat)
    end
end
