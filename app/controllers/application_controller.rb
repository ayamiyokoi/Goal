# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # ログイン済ユーザーのみにアクセスを許可する
  before_action :authenticate_user!, except: [:top, :about], if: :use_before_action?
   # deviseコントローラーにストロングパラメータを追加する
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_search


  protected
    def configure_permitted_parameters
      # サインアップ時にnameのストロングパラメータを追加
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      # アカウント編集の時にnameとprofile_image_urlのストロングパラメータを追加
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile_image, :introduction, :stage, :level])
    end

    def after_sign_in_path_for(resource)
      user_path(resource)
    end

    def use_before_action?
      true
    end

    def set_search
      @search = Review.ransack(params[:q])
      @search_reviews = @search.result
    end
end
