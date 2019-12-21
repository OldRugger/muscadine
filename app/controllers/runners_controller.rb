class RunnersController < ApplicationController

  def index
    render json: Runner.joins(:team).all.order(:school, "teams.name")
  end
end
