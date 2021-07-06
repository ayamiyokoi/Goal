class ChatsController < ApplicationController

  def index
  end

  def create
    @group = Group.find(params[:group_id])
    @chat = @group.chat.build(chat_params)
    @chat.user_id = current_user.id
    @chat.save
  end

  # def update
  #   @chat.update(chat_params)
  # end

  def destroy
    @chats = Chat.find_by(id: params[:id], group_id: params[:group_id]).destroy
  end

  private

  def chat_params
    params.require(:chat).permit(:chat)
  end

end
