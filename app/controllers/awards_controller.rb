class AwardsController < ApplicationController
  def index
    entry_class = params[:entry_class]
    runners = Runner.find_by_sql("SELECT firstname, surname, school, time1, time2, day1_score, day2_score, (day1_score + day2_score) as total  FROM runners where entryclass = '#{entry_class}' and day1_score > 0 and day2_score > 0 order by total;")
    render json: runners, each_serializer: RunnerSerializer
  end
end
