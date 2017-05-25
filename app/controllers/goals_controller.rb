class GoalsController < ApplicationController
  before_action :find_goal, only: [:edit, :update]

  def create
    goal = Goal.create(goal_params)
    if goal.persisted?
      redirect_to contact_path(id: goal_params[:contact_id]), notice: 'Goal created'
    else
      redirect_to contact_path(id: goal_params[:contact_id]), alert: 'Unable to create goal'
    end
  end

  def edit
  end

  def update
    @goal.update(goal_params)
    redirect_to contact_path(@goal.contact), notice: 'Goal updated'
  end

  private
    def find_goal
      @goal = Goal.find(params[:id])
    end

    def goal_params
      params.require(:goal).permit(:objective, :current, :achieved, :contact_id)
    end
end
