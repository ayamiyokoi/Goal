# frozen_string_literal: true

class NotificationsController < ApplicationController
  LIMIT_PER_PAGE = 10
  def index
    @notifications = current_user.passive_notifications.includes(:visitor, :visited, :review, :group).order(created_at: "DESC").page(params[:page]).per(LIMIT_PER_PAGE)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def destroy_all
    # 通知を全削除
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to request.referer
  end
end
