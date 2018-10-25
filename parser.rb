require 'rubygems'
require 'open-uri'
require 'spreadsheet'
require 'mysql2'
require 'csv'
require_relative 'school_hash'
require_relative 'district_hash'
require 'date'

# table1 = Spreadsheet.open '/home/krasno_o/Загрузки/1516ABS21DAYSchool.xls'
# sheet1 = table1.worksheet 0
# sheet1.each do |row|
#   p row
# end

# url = 'http://www.fldoe.org/core/fileparse.php/7584/urlt/1516ABS21DAYSDistrict.xls'
# doc = Spreadsheet.open (open(url))
# sheet1 = doc.worksheet 0
# sheet1.each do |row|
#   p row
# end

old_names_arr = Dir["xls_files/*"]

old_names_arr.each do |old_file_name|
  new_file_name = "#{old_file_name.gsub("xls_files/", "").gsub(".xls", "")}.csv"
  %x(ssconvert ~/work/xls_test/#{old_file_name} ~/work/xls_test/csv_files/#{new_file_name})
end

csv_files_names = Dir["csv_files/*"]

csv_files_names.each do |file_name|
  if file_name == 'csv_files/1516ABS21DAYSchool.csv'
    create_school_hash(file_name)
  elsif file_name == 'csv_files/1516ABS21DAYSDistrict.csv'
    create_district_hash(file_name)
  end
end
