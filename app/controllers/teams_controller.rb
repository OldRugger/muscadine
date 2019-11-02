class TeamsController < ApplicationController

  def import
    ActiveRecord::Base.transaction do
      return render json: { message: "No input file specified"}, status: :unprocessable_entity if params[:file] == nil
      @teams, @members = Team.import(params[:file])
    end
    render json: { teams: @teams, members: @members }, status: :created
  end

  def show
    team = Team.find(params[:id])
    runners = TeamMember.joins(:runner)
      .select("team_members.team_id, runners.id as runner_id,
              runners.firstname   as firstname,
              runners.surname     as surname,
              runners.time1       as time1,
              runners.time2       as time2,
              runners.float_time1 as float_time1,
              runners.float_time2 as float_time2,
              runners.day1_score  as day1_score,
              runners.day2_score  as day2_score,
              runners.entryclass  as entryclass ")
      .where(team_id: params[:id]).all

    awt = get_awt_hash
    day1_hash = awt[:day1]
    day2_hash = awt[:day2]
    render json: { team: team, runners: runners, day1: day1_hash, day2: day2_hash}
  end

end
