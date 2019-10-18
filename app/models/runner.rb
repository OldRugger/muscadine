require 'csv'
# Runner model
class Runner < ApplicationRecord
  has_one :team_member

  def update_runners_scores(day, awt, cat)
    classifier = self.send("classifier#{day}")
    if classifier
      update_day_score(classifier, day, awt, cat)
    end
    self.save
  end

  def self.import(file)
    added = 0
    skipped = 0
    self.clear_existing_data
    CSV.foreach(file.path, headers: true) do |row|
      if row["Short"].include? "IS"
        create_runner(row)
        added += 1
      else
        skipped += 1
      end
    end
    [added, skipped]
  end

  def self.import_results_row(row)
    float_time_one, time_one = self.get_float_time_from_value(row, "Time1")
    float_time_two, time_two = self.get_float_time_from_value(row, "Time2")
    float_total, total = self.get_float_time_from_value(row, "Total")
    Runner.where(database_id: row['Database Id'].to_s)
      .update_all(time1: time_one,
                  float_time1: float_time_one,
                  classifier1: row["Classifier1"].to_s,
                  time2: time_two,
                  float_time2: float_time_two,
                  classifier2: row["Classifier2"].to_s,
                  total_time: total,
                  float_total_time: float_total)

  end

  private

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

  def self.create_runner(row)
    Runner.create(database_id: row["Database Id"],
      surname: row["Surname"].gsub("'"){"\\'"},
      firstname: row["First name"].gsub("'"){"\\'"},
      school: row["City"].gsub("'"){"\\'"},
      entryclass: row["Short"],
      gender: row['S'])
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
    elsif (classifier === "0" && float_time1 > 0 && awt)
      self.send("day#{day}_score=", 60 * (float_time/awt[:awt]) )
    end
  end


end
