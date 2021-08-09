# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i(show edit update destroy confirm)
  LIMIT_PER_PAGE = 5
  LEVEL_UP_POINT = 10

  # GET /tasks or /tasks.json
  def index
    # 自分のタスクのみ表示、処理済、未処理で判別
    @tasks_active = Task.where(user_id: current_user.id, finished: false).order(date: "ASC").page(params[:page]).per(LIMIT_PER_PAGE)
    @tasks_done = Task.where(user_id: current_user.id, finished: true).order(date: "DESC").page(params[:page]).per(LIMIT_PER_PAGE)
    @task = Task.new
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: "タスクを作成しました。" }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        # 目標達成で5pt, タスク達成で2pt, 振り返り投稿で1pt、自分のレベルの10倍のポイントがたまるとレベルアップ
        if Goal.goal_point(current_user) + Task.task_point(current_user) + Review.review_point(current_user) > LEVEL_UP_POINT*current_user.level
          # レベル+1
          current_user.upgrade_level
          flash[:notice] = "レベル「＋１」アップ 、現在のレベルは#{current_user.level}です。"
        end
        format.html { redirect_to @task, notice: "タスクを更新しました。" }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "タスクを削除しました。" }
      format.json { head :no_content }
    end
  end

  def confirm
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:name, :body, :date, :finished)
  end
end
