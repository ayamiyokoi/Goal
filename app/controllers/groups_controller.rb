# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :set_group, only: %i(show edit update destroy join)
  before_action :set_users, only: %i(index edit)
  LIMIT_PER_PAGE = 10

  def index
    @groups_all = Group.all.page(params[:page]).per(LIMIT_PER_PAGE)
    @groups_mine = current_user.groups.page(params[:page]).per(LIMIT_PER_PAGE)
    @group = Group.new
    @group.group_users.build
  end

  def show
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    @group.users << current_user
    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: "グループの作成に成功しました。" }
        format.json { render :show, status: :created, location: @group }
      else
        @groups_all = Group.all.page(params[:page]).per(LIMIT_PER_PAGE)
        @groups_mine = current_user.groups.page(params[:page]).per(LIMIT_PER_PAGE)
        set_users
        format.html { render :index }
        format.json { render json: @group.errors }
      end
    end
  end

  def update
    # 自分をグループに追加
    update_params = group_params
    update_params[:user_ids].push(current_user.id)
    respond_to do |format|
      if @group.update(update_params)
        format.html { redirect_to @group, notice: "グループの更新が成功しました。" }
        format.json { render :show, status: :ok, location: @group }
      else
        set_users
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: "グループは削除されました" }
      format.json { head :no_content }
    end
  end

  # def join
  #   @group.users << current_user
  #   if @group.save
  #     redirect_to group_path(@group)
  #   else
  #     redirect_to request.referer
  #   end
  # end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def set_users
    @users = User.where(id: Friend.where(myself_id: current_user.id).pluck('friend_id'))
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:name, :group_image, user_ids: [])
  end
end
