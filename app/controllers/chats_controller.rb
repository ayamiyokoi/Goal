class ChatsController < ApplicationController
  def index
    @chats = Chat.all
    @chat = Chat.new
  end
  
  def create
  end
  
  def update
  end
  
  def destroy
  end

end
