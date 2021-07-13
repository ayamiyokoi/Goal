# frozen_string_literal: true

class ChatsController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @chat = Chat.new
    @chats = @group.chats
  end

  def create
    @group = Group.find(params[:group_id])
    @chat = @group.chats.build(chat_params)
    @chat.user_id = current_user.id
    @chat.save
    @chats = @group.chats
  end

  # def update
  #   @chat.update(chat_params)
  # end

  def destroy
    @group = Group.find(params[:group_id])
    @chats = Chat.find_by(id: params[:id], group_id: params[:group_id]).destroy
    @chats = @group.chats
  end

  private
    def chat_params
      params.require(:chat).permit(:chat)
    end
end
