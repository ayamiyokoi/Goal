# frozen_string_literal: true

class ChatsController < ApplicationController
  before_action :set_group, only: %i(index create destroy)

  def index
    @chat = Chat.new
    @chats = @group.chats.includes(:user)
  end

  def create
    @chat = @group.chats.build(chat_params)
    @chat.user_id = current_user.id
    if @chat.save
      @chat.create_notification_chat(current_user, @group.id, @group.user_ids, @chat.id)
    else
      render 'error'
    end
    @chats = @group.chats.includes(:user)
  end

  def destroy
    @chats = Chat.find_by(id: params[:id], group_id: params[:group_id]).destroy
    @chats = @group.chats.includes(:user)
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_chats
    @chats = @group.chats.includes(:user)
  end

  def chat_params
    params.require(:chat).permit(:chat)
  end
end
