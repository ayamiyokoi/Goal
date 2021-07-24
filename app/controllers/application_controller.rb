# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # 各アクションで権限をチェック。オプションでモデル依存をfalseに。
  authorize_resource :class => false

  # ログイン済ユーザーのみにアクセスを許可する
  before_action :authenticate_user!, except: [:top, :about], if: :use_before_action?
   # deviseコントローラーにストロングパラメータを追加する
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_search



  # 権限が無いページへアクセス時の例外処理
  rescue_from CanCan::AccessDenied do |exception|
    # root_urlに飛ばす。
    redirect_to root_url
  end

  protected
    def configure_permitted_parameters
      # サインアップ時にnameのストロングパラメータを追加
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      # アカウント編集の時にnameとprofile_image_urlのストロングパラメータを追加
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile_image, :introduction, :stage, :level, :show_status, :searchable, :custom_id])
    end

    def after_sign_in_path_for(resource)
      user_path(resource)
    end

    def use_before_action?
      true
    end

    def set_search
      #TODO: 知人と公開ステータスのやつのみとる
      #TODO: 結果のレイアウト編集
      @search = Review.ransack(params[:q])
      @search_reviews = @search.result
    end
end
