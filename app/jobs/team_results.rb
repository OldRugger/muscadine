require 'csv'

# This class load the 2 day results file and clculates the team scores.
class TeamResults
  include SuckerPunch::Job
  include ApplicationHelper
  include JobsHelper

  def perform(file)
    process_results_file(file[0])
    calculate_awt
  end

  def calculate_awt
    ActiveRecord::Base.transaction do
      delete_awt_results
      calculate_results
      update_team_scores
    end
  end

  def calculate_results
    calculate_awt_by_class("ISP")
    calculate_awt_by_class("ISI")
    calculate_awt_by_class("ISJV")
    calculate_awt_by_class("ISV")
  end

  def calculate_awt_by_class(team_class)
    day1_awt_m, day1_awt_f, day1_cat = calculate_day_results(team_class, 1)
    day2_awt_m, day2_awt_f, day2_cat = calculate_day_results(team_class, 2)
    update_day_scores(day1_awt_m, day2_awt_m, day1_cat, day2_cat, team_class, "M")
    update_day_scores(day1_awt_f, day2_awt_f, day1_cat, day2_cat, team_class, "F")
  end

  def calculate_day_results(team_class, day)
    day_awt_m = calculate_awt_by_class_gender(team_class, "M", day)
    day_awt_f = calculate_awt_by_class_gender(team_class, "F", day)
    day_cat = get_category_time(day_awt_m, day_awt_f)
    update_awt(day_awt_m, day_awt_f, day_cat, team_class, day)
  end

  def update_awt(day_awt_m, day_awt_f, day_cat, team_class, day)
    male_entryclass = team_class + "M"
    female_entryclass = team_class + "F"
    update_day_awt(day_awt_m, male_entryclass, day, day_cat) if day_awt_m
    update_day_awt(day_awt_f, female_entryclass, day, day_cat) if day_awt_f
    [day_awt_m, day_awt_f, day_cat]
  end


  def update_day_scores(awt1, awt2, day1_cat, day2_cat, team_class, gender)
    runners = Runner.where(entryclass: team_class+gender)
    runners.each do |runner|
      runner.update_runners_scores(1, awt1, day1_cat)
      runner.update_runners_scores(2, awt2, day2_cat)
      # day1_classifier = runner.classifier1
      # day2_classifier = runner.classifier2

      # if day1_classifier
      #   if  day1_classifier != "0"
      #     runner.day1_score = 10 + (60 * (max_time/day1_cat))
      #   elsif (day1_classifier === "0" && runner.float_time1 > 0 && awt1)
      #     runner.day1_score = 60 * (runner.float_time1/awt1[:awt])
      #   end
      # end
      # if day2_classifier
      #   if day2_classifier != "0"
      #     runner.day2_score = 10 + (60 * (max_time/day2_cat))
      #   elsif (day2_classifier === "0" && runner.float_time2 > 0 && awt2)
      #     runner.day2_score = 60 * (runner.float_time2/awt2[:awt])
      #   end
      #   if (awt1 || awt2)
      #     runner.save
      #   end
      # end
    end
  end

  def calculate_awt_by_class_gender(team_class, gender, day)
    times = []
    awt_runners = Runner.where(entryclass: team_class+gender)
                    .where("classifier#{day} = 0 and float_time#{day} > 0" )
                      .order("float_time#{day}").limit(3)
    return nil if awt_runners.count == 0
    awt_runners.each { |r| times.push(r.send("float_time#{day}")) }
    awt = get_awt_time(times)
    {runners: awt_runners, awt: awt}
  end

end