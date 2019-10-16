class TeamsController < ApplicationController

  def import
    ActiveRecord::Base.transaction do
      return render json: { message: "No input file specified"}, status: :unprocessable_entity if params[:file] == nil
      @teams, @members = Team.import(params[:file])
    end
    render json: { teams: @teams, members: @members }, status: :created
   end

end
