class FriendsController < ApplicationController

  def create
    friend = Friend.new
    friend.myself_id = current_user.id
    friend.friend_id = params[:id]
    friend.save
    #友達と自分の両方を登録
    friend.myself_id = params[:id]
    friend.friend_id = current_user.id
    friend.save
    redirect_to users_path
    flash[:notice] = "知人として登録完了しました。"
  end

  def destroy
    friend = Friend.find(params[:id])
    friend.destroy
    redirect_to request.referer
  end

  # private
  # def friend_params
  #   params.require(:friend).permit(:friend_id)
  # end
end
