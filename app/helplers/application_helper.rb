# Application Support functions
module ApplicationHelper
  CLASS_LIST =  ['ISVM', 'ISVF', 'ISJVM', 'ISJVF', 'ISIM', 'ISIF', 'ISPM', 'ISPF'].freeze

  def float_time_to_hhmmss(float_time)
    if (float_time && float_time > 0)
      hhmmss = convert_float_to_hhmmss(float_time)
    else
      hhmmss = ""
    end
    hhmmss
  end

  def convert_float_to_hhmmss(float_time)
    min = float_time.floor
    mm = (min % 60).floor
    hh = (min / 60).floor
    ss = ((float_time - min) * 60).round
    hhmmss = "#{hh.to_s}:#{format('%02d', mm)}:#{format('%02d', ss)}"
  end

  def get_awt_hash
    day1_hash = get_awt_hash_by_day(1)
    day2_hash = get_awt_hash_by_day(2)
    {day1: day1_hash, day2: day2_hash}
  end

  def get_awt_hash_by_day(day)
    klass = "Day#{day}Awt".constantize
    day_awts = klass.all
    day_hash = Hash.new
    day_awts.each do |awt|
      day_hash[awt.entryclass] = {awt: float_time_to_hhmmss(awt.awt_float_time),
                                   cat: float_time_to_hhmmss(awt.cat_float_time) }
    end
    day_hash
  end

  def get_awt_with_runners
    @awt = Hash.new
    2.times do |n|
      day = n + 1
      @awt[day] = Hash.new
      klass = "Day#{day}Awt".constantize
      awt = klass.all
      awt.each do |result|
        @awt[day][result.entryclass] = float_time_to_hhmmss(result.awt_float_time) if result.awt_float_time > 0
        @awt[day]["#{result.entryclass}_cat"] = float_time_to_hhmmss(result.cat_float_time) if result.cat_float_time > 0
        get_runners(day, result)
      end
    end
    @awt
  end

  private

  def get_runners (day, result)
    3.times do |n|
      r = n + 1
      if result.send("runner#{r}_float_time") == 0
        time = "n/a*"
      else
        time = float_time_to_hhmmss(result.send("runner#{r}_float_time"))
      end
      @awt[day]["#{result.entryclass}#{r}"] = time
    end
  end

end