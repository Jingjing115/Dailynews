class DailiesController < ApplicationController
  before_filter :authenticate_user!

  def index
    begin
      date = params[:date].to_date || Time.now.to_date
    rescue
      date = Time.now.to_date
    end
    current_page = params[:current_page] ? [params[:current_page].to_i, 1].max : 1
    @dailies = Daily.where(created_at: date.beginning_of_day..date.end_of_day).paginate(page: current_page, per_page: 10)
    @current_page = current_page
  end

  def show
    @daily = Daily.find_by(id: params[:id])
  end

  def my_today_daily
    @daily = Daily.where(user_id: current_user.id, created_at: Time.now.to_date.beginning_of_day..Time.now.to_date.end_of_day).first
    if @daily
      render 'show'
    else
      @daily = Daily.new
      render 'new'
    end
  end

  def new
    @daily = Daily.new
  end

  def edit
  	@daily = Daily.where(user_id: current_user.id, id: params[:id], created_at: Time.now.to_date.beginning_of_day..Time.now.to_date.end_of_day).first
	end

  def update
    @daily = Daily.find(params[:id])
    if @daily.update(daily_params)
      redirect_to @daily
    else
      render 'edit'
    end
  end

  def create
    @daily = Daily.new daily_params
    @daily.user_id = current_user.id
    if @daily.save
      redirect_to @daily
    else
      render 'new'
    end
  end

  private

  def daily_params
    params.require(:daily).permit(:title, :content, :spec_type)
  end
end
