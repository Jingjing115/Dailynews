class DailiesController < ApplicationController
  before_filter :authenticate_user!

  BackwardsTime = 6.hours

  def goals
    time = Time.now
    @month_goals = Daily.month_goal.where(goal_info: "#{time.year}-#{time.month}").order(created_at: :desc)
    @quarter_goals = Daily.quarter_goal.where(goal_info: "#{time.year}-#{((time.month - 1) / 3) + 1}").order(created_at: :desc)
    @year_goals = Daily.year_goal.where(goal_info: "#{time.year}").order(created_at: :desc)
    render 'goals'
  end

  def index
    begin
      @date = params[:date].to_date || (Time.now - BackwardsTime).to_date
    rescue
      @date = (Time.now - BackwardsTime).to_date
    end
    @dailies = Daily.daily.where(created_at: (@date.beginning_of_day + BackwardsTime)..(@date.end_of_day + BackwardsTime)).order(created_at: :desc)
  end

  def new
    @daily = Daily.daily.where(user_id: current_user.id, created_at: (Time.now.beginning_of_day + BackwardsTime)..(Time.now.end_of_day + BackwardsTime)).first
    if @daily
      render 'edit'
    else
      @daily = Daily.new
    end
  end

  def edit
  	@daily = Daily.daily.where(user_id: current_user.id, id: params[:id], created_at: (Time.now.beginning_of_day + BackwardsTime)..(Time.now.end_of_day + BackwardsTime)).first
	end

  def update
    @daily = Daily.daily.find(params[:id])
    if @daily.update(daily_params)
      @date = (Time.now - BackwardsTime).to_date
      @dailies = Daily.daily.where(created_at: (@date.beginning_of_day + BackwardsTime)..(@date.end_of_day + BackwardsTime)).order(created_at: :desc)
      render 'index'
    else
      render 'edit'
    end
  end

  def create
    @daily = Daily.new daily_params
    @daily.user_id = current_user.id
    if @daily.save
      @date = (Time.now - BackwardsTime).to_date
      @dailies = Daily.daily.where(created_at: (@date.beginning_of_day + BackwardsTime)..(@date.end_of_day + BackwardsTime)).order(created_at: :desc)
      render 'index'
    else
      render 'new'
    end
  end

  private

  def daily_params
    params.require(:daily).permit(:title, :content, :spec_type)
  end
end
