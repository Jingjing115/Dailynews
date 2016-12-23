class DailiesController < ApplicationController
  before_filter :authenticate_user!

  BackwardsTime = 6.hours

  def time_range date = @date || default_date
    (date.beginning_of_day + BackwardsTime)..(date.end_of_day + BackwardsTime)
  end

  def default_date
    (Time.now - BackwardsTime).to_date
  end

  def goals
    time = Time.now
    @month_goals = Daily.month_goal.where(goal_info: "#{time.year}-#{time.month}").order(created_at: :desc)
    @quarter_goals = Daily.quarter_goal.where(goal_info: "#{time.year}-#{((time.month - 1) / 3) + 1}").order(created_at: :desc)
    @year_goals = Daily.year_goal.where(goal_info: "#{time.year}").order(created_at: :desc)
    render 'goals'
  end

  def index
    begin
      @date = params[:date].to_date || default_date
    rescue
      @date = default_date
    end
    @dailies = Daily.daily.where(created_at: time_range).order(created_at: :desc)
  end

  def new
    @daily = Daily.daily.where(user_id: current_user.id, created_at: time_range).first
    if @daily
      render 'edit'
    else
      @daily = Daily.new
    end
  end

  def edit
  	@daily = Daily.daily.where(user_id: current_user.id, id: params[:id], created_at: time_range).first
	end

  def update
    @daily = Daily.daily.where(user_id: current_user.id, id: params[:id], created_at: time_range).first
    if @daily.update(daily_params)
      @date = default_date
      @dailies = Daily.daily.where(created_at: time_range).order(created_at: :desc)
      render 'index'
    else
      render 'edit'
    end
  end

  def create
    @daily = Daily.daily.where(user_id: current_user.id, created_at: time_range).order(created_at: :desc).first
    if @daily
      if @daily.update_attributes(daily_params)
        @date = default_date
        @dailies = Daily.daily.where(created_at: time_range).order(created_at: :desc)
        render 'index'
      else
        render 'edit'
      end
    else
      @daily = Daily.new daily_params
      @daily.user_id = current_user.id
      if @daily.save
        @date = default_date
        @dailies = Daily.daily.where(created_at: time_range).order(created_at: :desc)
        render 'index'
      else
        render 'new'
      end
    end
  end

  private

  def daily_params
    params.require(:daily).permit(:title, :content, :spec_type)
  end
end
