class ResultsController < ApplicationController

  def clear
    puts "====> clear all resutls <====="
    TeamMember.delete_all
    Team.delete_all
    Runner.delete_all
    Day1Awt.delete_all
    Day2Awt.delete_all
    render json: {tableCounts: {
        TeamMember: TeamMember.count,
        Team: Team.count,
        Runner: Runner.count,
        Day1Awt: Day1Awt.count,
        Day2Awt: Day2Awt.count
      }
    }

  end

  def awt
    awt = get_awt_with_runners
    render json: awt.to_json
  end

  def classes
    render json: { classes: CLASS_LIST }
  end

  def teams
    awt = get_awt_hash
    classes = get_teams_by_class
    get_results_by_day(awt)

    render json: {awt: awt, classes: classes}

  end

  private

  def get_teams_by_class
    isp = Team.where(entryclass: 'ISP').order(:sort_score, :day1_score, :name)
    isi = Team.where(entryclass: 'ISI').order(:sort_score, :day1_score, :name)
    isjv = Team.where(entryclass: 'ISJV').order(:sort_score, :day1_score, :name)
    isv = Team.where(entryclass: 'ISV').order(:sort_score, :day1_score, :name)
    jrotc = Team.where(entryclass: 'ISV').where.not(JROTC_branch: nil).order(:sort_score, :day1_score, :name)

    classes = { 'isv'   => isv,
                'isjv'  => isjv,
                'isi'   => isi,
                'isp'   => isp,
                'jrotc' => jrotc }
  end

  def get_results_by_day(awt)
    ["1", "2"].each do |day|
      awt_day = "day#{day}".to_sym
      isday = get_runner_results(day)
      process_is_day_results(isday, awt[awt_day], day)
    end
  end

  def get_runner_results(day)
    isday = TeamMember.joins(:runner)
      .select("team_members.team_id,runners.id as runner_id,
                runners.day#{day}_score as day#{day}_score,
                runners.surname")
      .order("team_members.team_id, runners.day#{day}_score")
      .load
  end

  def  process_is_day_results(isday, day_hash, day)
    team_id = 0
    team_name = nil
    results_str = nil
    isday.each do |d|
      if team_id != d.team_id
        if team_id != 0
          day_hash[team_name] = {"results": results_str, "id": team_id} if team_id !=0
        end
        team_id = d.team_id
        team_name = Team.find(team_id).name
        results_str = nil
      end
      day_score = d.send("day#{day}_score")
      if  day_score
        if results_str != nil
          results_str.concat(", #{d.surname} (#{sprintf "%.4f", day_score.round(4)})")
        else
          results_str = "#{d.surname} (#{sprintf "%.4f", day_score.round(4)})"
        end
      end
    end
    day_hash[team_name] = {"results": results_str, "id": team_id} if results_str
  end

end