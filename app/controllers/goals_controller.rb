class GoalsController < ApplicationController
  before_action :set_goal, only: %i[ edit update destroy ]
  
  
  def index
    # 自分の目標のみ表示
    @goals = Goal.where(user_id: current_user.id)
    @goal = Goal.new
  end
  
  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to request.referer
    else
      redirect_to '/'
    end
  end

  def edit
  end
  
  def update
    if @goal.update(goal_params)
      redirect_to goals_path
    else
      redirect_to '/'
    end
  end
  
  def destroy
    @group.destroy
    redirect_to goals_path
  end
  
  
  private
  
  def set_goal
      @goal = Goal.find(params[:id])
  end
   
  def goal_params
    params.require(:goal).permit(:name, :date, :achieved)
  end
end
