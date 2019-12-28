require 'csv'
require 'pry'

def csv_with_excel_dates(input, out)
  CSV.foreach(input, :headers => false, :col_sep=> ',', :skip_blanks=>true, :row_sep=>:auto ) do |row|
    row[13] = "00:" + row[13] if row[13] && row[13].split(":").size == 2
    out << row
  end
  out.close
end

input = 'OE0014_day_one_results_final.csv'
out = CSV.open('day_one.csv', 'wb')

csv_with_excel_dates(input, out)

input = 'OE0014_day_two_results_final.csv'
out = CSV.open('day_two.csv', 'wb')

csv_with_excel_dates(input, out)