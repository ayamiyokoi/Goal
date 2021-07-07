class ApplicationController < ActionController::Base
  # ログイン済ユーザーのみにアクセスを許可する
  before_action :authenticate_user!
   # deviseコントローラーにストロングパラメータを追加する  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  before_action :set_search

  protected
  
  def configure_permitted_parameters
    # サインアップ時にnameのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # アカウント編集の時にnameとprofile_image_urlのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile_image])
  end
  
  def after_sign_in_path_for(resource)
    user_path(resource.id)
  end
  
  def set_search
    @search = Review.ransack(params[:q])
    @search_reviews = @search.result
  end
end
