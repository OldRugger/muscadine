require 'csv'
# Runner model
class Runner < ApplicationRecord
  has_one :team_member
  has_one :team, through: :team_member

  def update_runners_scores(day, awt, cat)
    classifier = self.send("classifier#{day}")
    if classifier
      update_day_score(classifier, day, awt, cat)
    end
    self.save
  end

  def self.import_results_row(row)
    time_key = APP_CONFIG[:input]['fields']['time']
    classifier_key = APP_CONFIG[:input]['fields']['classifier']
    day = APP_CONFIG[:input]['day']
    runner = self.find_or_create_runner(row)
    float_time, time = self.get_float_time_from_value(row, time_key)
    if day == 1
      runner.time1 = time
      runner.float_time1 = float_time
      runner.classifier1 = row[classifier_key]
    end
    if day == 2
      runner.time2 = time
      runner.float_time2 = float_time
      runner.classifier2 = row[classifier_key]
    end
    if  runner.float_time1 &&  runner.float_time2
      runner.float_total_time = (runner.float_time1 ? runner.float_time1 : 0) + (runner.float_time2 ? runner.float_time2 : 0)
      ## TODO - get display time
    end
    runner.save
  end

  def as_json(options = {})
    time1 = self.time1 ? self.time1.strftime("%T") : ""
    time2 = self.time2 ? self.time2.strftime("%T") : ""
    day1_score = self.day1_score ? self.day1_score.round(4) : ""
    day2_score = self.day2_score ? self.day2_score.round(4) : ""
    total_time = get_total_time
    total_score = get_total_score

    super(options).merge({
      'team_name' => self.team.name,
      'time1' => time1,
      'time2' => time2,
      'day1_score' => day1_score,
      'day2_score' => day2_score,
      'total_time' => total_time,
      'total_score' => total_score
    })
  end

  private

  def get_total_time
    total_time = ""
    if (self.classifier1 == "0" && self.time1) &&
       (self.classifier2 == "0" && self.time2)
       total_time = (time1 + time2).strftime("%T")
    end
    total_time
  end

  def get_total_score
    return (self.day1_score + self.day2_score).round(3) if self.day1_score && self.day2_score
    ''
  end

  def self.find_or_create_runner(row)
    unique_id =  APP_CONFIG[:input]["fields"]["unique_id"]
    runner = Runner.where(database_id: row[unique_id]).first
    return runner if runner
    self.create_runner(row)
  end

  def self.create_runner(row)
    fields = APP_CONFIG[:input]["fields"]
    runner = Runner.create(database_id: row[fields["unique_id"]],
      surname: row[fields["lastname"]].gsub("'"){"\\'"},
      firstname: row[fields["firstname"]].gsub("'"){"\\'"},
      school: row[fields["school"]].gsub("'"){"\\'"},
      entryclass: row[fields["entry_class"]],
      gender: row[fields["gender"]])
    Team.assign_member(row, fields, runner) if row[fields["team"]]
    runner
  end



  def self.get_float_time_from_value(row, value)
    time = row[value]
    if (time)
      res = self.get_float_time(time)
      float_time = res['float']
      time =  res['time']
    else
      float_time = 0.0
    end
    [float_time, time]
  end

  def self.clear_existing_data
    TeamMember.delete_all
    Team.delete_all
    Day1Awt.delete_all
    Day2Awt.delete_all
    Runner.delete_all
  end

  def self.get_float_time(time)
    hhmmss = time.split(":")
    length = hhmmss.length
    if length == 3
      float_time = self.get_hhmmss_time(hhmmss)
    elsif length == 2
      float_time = self.get_mmss_time(hhmmss)
      time = "00:" + time
    end
    {'float' => float_time, 'time' => time}
  end

  def self.get_hhmmss_time(hhmmss)
      hh = hhmmss[0].to_i
      mm = hhmmss[1].to_i
      ss = hhmmss[2].to_i
      float_time = (hh*60) + mm + (ss/60.0)
  end

  def self.get_mmss_time( hhmmss)
      mm = hhmmss[0].to_i
      ss = hhmmss[1].to_i
      float_time = mm + (ss/60.0)
      float_time
  end

  def update_day_score(classifier, day, awt, cat)
    max_time = APP_CONFIG[:max_time]
    float_time = self.send("float_time#{day}")
    if  classifier != "0"
      self.send("day#{day}_score=", 10 + (60 * (max_time/cat) ) )
    elsif (classifier === "0" && float_time > 0 && awt)
      self.send("day#{day}_score=", 60 * (float_time/awt[:awt]) )
    end
  end


end
