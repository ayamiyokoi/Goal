class FriendsController < ApplicationController
  
  def create
    friend.myself_id = current_user.id
    friend.friend_id = @user.id
    friend.save
    redirect_to request.referer
    flash[:notice] = "知人として登録完了しました。"
  end
  
  def delete
  end
end
