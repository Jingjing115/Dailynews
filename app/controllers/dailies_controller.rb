class DailiesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @dailies = Daily.all
  end

  def show
    @daily = Daily.find_by(id: params[:id])
  end

end
