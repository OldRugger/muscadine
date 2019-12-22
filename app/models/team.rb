require 'csv'
# team model / methods
class Team < ApplicationRecord
  has_many :team_members

  def update_team_scores
    sortvalue = 9999.0
    day1_score = get_team_day_scores(1)
    day2_score = get_team_day_scores(2)
    self.total_score = day1_score + day2_score
    self.day1_score  = day1_score > 0.0 ? day1_score : sortvalue
    self.day2_score  = day2_score > 0.0 ? day2_score : sortvalue
    self.sort_score  = self.day1_score + self.day2_score
  end

  def self.assign_member(row, runner)
    config = Config.last
    team_entry_class = get_team_entry_class(row[config.entry_class])
    team_name = row[config.team].rstrip
    school_name = row[config.school].rstrip
    team = Team.where(name: team_name, school: school_name, entryclass: team_entry_class).first
    team = create_team(team_name, school_name, row[config.jrotc], team_entry_class) if !team
    self.assign_runner_to_team(team, runner, row, config)
  end
  private

  def get_team_day_scores(day)
    day_score = 0.0

    select = "team_members.id, team_members.team_id ,runners.id as runner_id, runners.day#{day}_score as day_score"
    scores = TeamMember.joins(:runner)
      .select(select)
      .where(team_id: self.id).where("runners.day#{day}_score > ?", 0.0)
      .order("runners.day#{day}_score")
      .limit(3)

    if scores.size === 3
      scores.each do |score|
        day_score += score.day_score if score.day_score
      end
    end
    day_score
  end

  def self.create_team(team_name, school_name, jrotc, team_entry_class)
    Team.create(name: team_name,
                entryclass: team_entry_class,
                JROTC_branch:jrotc,
                school: school_name)
  end

  # match name, school and entry class and no other assignment.
  def self.assign_runner_to_team(team, runner, row, config)
    raise "error: runner already assigned to a team " if TeamMember.where(runner_id: runner.id).first
    raise "error: invalid entry class #{row}" unless runner.entryclass.include? team.entryclass
    raise "error: runner first name does not match #{row}" unless runner.firstname = row[config.firstname].gsub("'"){"\\'"}
    raise "error: runner last name does not match #{row}" unless runner.surname = row[config.lastname].gsub("'"){"\\'"}
    TeamMember.create(team_id: team.id,
                      runner_id: runner.id)
  end

  def self.get_team_entry_class(entry_class)

    team_entry_class = nil
    case entry_class
      when 'ISPM', 'ISPF'
        team_entry_class = 'ISP'
      when 'ISIM', 'ISIF'
        team_entry_class = 'ISI'
      when 'ISJVM', 'ISJVF'
        team_entry_class = 'ISJV'
      when 'ISVM', 'ISVF'
        team_entry_class = 'ISV'
    end
    team_entry_class
  end

end

