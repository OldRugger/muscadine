class RunnerSerializer < ActiveModel::Serializer
  attributes :firstname, :surname, :school, :team, :time1, :time2, :day1_score, :day2_score, :total
end
