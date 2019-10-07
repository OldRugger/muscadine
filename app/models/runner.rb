require 'csv'

class Runner < ApplicationRecord
  has_one :team_member
  def self.import(file)
    added = 0
    skipped = 0
    self.clear_existing_data
    CSV.foreach(file.path, headers: true) do |row|
      if row["Short"].include? "IS"
        Runner.create(database_id: row["Database Id"],
                      surname: row["Surname"].gsub("'"){"\\'"},
                      firstname: row["First name"].gsub("'"){"\\'"},
                      school: row["City"].gsub("'"){"\\'"},
                      entryclass: row["Short"],
                      gender: row['S'])
        added += 1
      else
        skipped += 1
      end
    end
    [added, skipped]
  end

  private

  def self.clear_existing_data
    TeamMember.delete_all
    Team.delete_all
    Day1Awt.delete_all
    Day2Awt.delete_all
    Runner.delete_all
  end

  def self.get_float_time(time)
    float_time = 0.0
    hhmmss = time.split(":")
    if (hhmmss.length ==3 ) then
      time = time
      hh = hhmmss[0].to_i
      mm = hhmmss[1].to_i
      ss = hhmmss[2].to_i
      float_Time = (hh*60) + mm + (ss/60.0)
    elsif (hhmmss.length == 2) then
      time = "00:" + time
      mm = hhmmss[0].to_i
      ss = hhmmss[1].to_i
      float_Time = mm + (ss/60.0)
    end
    {'float' => float_Time, 'time' => time}
  end

end
