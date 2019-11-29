module JobsHelper

  def update_team_scores
    sortvalue = 9999.0
    teams = Team.all
    teams.each do |team|
      team.update_team_scores
      team.save
    end
  end

  def delete_awt_results
    Day1Awt.delete_all
    Day2Awt.delete_all
  end

  def get_awt_time(times)
    times.inject(0.0) { |sum, el| sum + el } / times.size
  end

  def process_results_file(file)
    entry_class = APP_CONFIG[:input]["fields"]["entry_class"]
    ActiveRecord::Base.transaction do
      CSV.foreach(file, :headers => true, :col_sep=> ',', :skip_blanks=>true, :row_sep=>:auto ) do |row|
        Runner.import_results_row(row) if row[entry_class].start_with?('IS')
      end
    end
    File.delete(file)
  end

  def update_day_awt(awt, entryclass, day, cat_time)
    klass = "Day#{day}Awt".constantize
    float_time = "float_time#{day}".to_sym
    time_day = "time#{day}".to_sym
    runners = awt[:runners]
    first_runner = runners[0]
    second_runner = runners[1]
    third_runner = runners[2]

    klass.create do |awt_row|
      awt_row.entryclass          =  entryclass
      awt_row.runner1_id          =  first_runner[:id]
      awt_row.runner1_float_time  =  first_runner[float_time]
      awt_row.runner1_time        =  first_runner[time_day]
      if second_runner
        awt_row.runner2_id          =  second_runner[:id] || nil
        awt_row.runner2_float_time  =  second_runner[float_time] || nil
        awt_row.runner2_time        =  second_runner[time_day] || nil
      end
      if third_runner
        awt_row.runner3_id          =  third_runner[:id]
        awt_row.runner3_float_time  =  third_runner[float_time]
        awt_row.runner3_time        =  third_runner[time_day]
      end
      awt_row.cat_float_time      =  cat_time
      awt_row.awt_float_time      =  awt[:awt]
    end
  end

  def get_category_time(m_awt, f_awt)
    male = 0
    female = 0
    male = m_awt[:awt] if m_awt
    female = f_awt[:awt] if f_awt
    cat_time = male < female  ? male : female
  end

end
