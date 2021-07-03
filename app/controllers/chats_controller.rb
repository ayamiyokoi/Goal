class ChatsController < ApplicationController

  def index
    @chats = Chat.where(group_id: params[:group_id])
    @chat = Chat.new
    @group = Group.find(params[:group_id])
  end

  def create
    @chat = Chat.new(chat_params)
    @chat.user_id = current_user.id
    @chat.group_id = params[:group_id]
    if @chat.save
      redirect_to group_chats_path(params[:group_id])
    else
      redirect_to '/'
    end
  end

  # def update
  #   @chat.update(chat_params)
  # end

  def destroy
    @chat = Chat.find(params[:group_id], params[:id])
    if @chat.destroy
      redirect_to request.referer
    else
      redirect_to '/'
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:chat)
  end

end
