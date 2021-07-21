# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy join ]
  before_action :set_users, only: %i[ index edit ]

  # GET /groups or /groups.json
  def index
    @groups_all = Group.all.page(params[:page]).per(10)
    @groups_mine = current_user.groups.page(params[:page]).per(10)
    @group = Group.new
   # @users = User.joins(:friends).where(friends: { myself_id: current_user.id})
  end

  # GET /groups/1 or /groups/1.json
  def show
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups or /groups.json
  def create
    @group = Group.new(group_params)
    @group.users << current_user
    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: "グループの作成に成功しました。" }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { redirect_to groups_path :index, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    @group.users << current_user
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: "グループの更新が成功しました。" }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: "グループは削除されました" }
      format.json { head :no_content }
    end
  end

  #TODO: これいらない気がする
  def join
    @group.users << current_user
    if @group.save
      redirect_to group_path(@group)
    else
      redirect_to request.referer
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    def set_users
      @users = User.where(id: Friend.where(myself_id: current_user.id).pluck('friend_id'))
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.require(:group).permit(:name, :group_image, user_ids: [] )
    end
end
