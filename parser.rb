require 'rubygems'
require 'open-uri'
require 'spreadsheet'
require 'mysql2'
require 'csv'
require_relative 'tables/schools_saver'
require_relative 'tables/districts_saver'
require_relative 'school_hash'
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

# old_names_arr = Dir["xls_files/*"]
#
# old_names_arr.each do |old_file_name|
#   new_file_name = "#{old_file_name.gsub("xls_files/", "").gsub(".xls", "")}.csv"
#
#   %x( ssconvert ~/work/xls_test/xls_files/#{old_file_name} #{new_file_name})
#   ssconvert ~/work/xls_test/xls_files/#{old_file_name} ~/work/xls_test/csv_files/#{new_file_name})
# end

csv_files_names = Dir["csv_files/*"]

csv_files_names.each do |file_name|
  # if file_name == 'csv_files/1516ABS21DAYSchool.csv'
  #   create_school_hash(file_name)
  #
  # end
  if file_name == 'csv_files/1516ABS21DAYSDistrict.csv'
    index = 0
    CSV.foreach("/home/krasno_o/work/xls_test/#{file_name}") do |row|
      if index > 2
        begin
          p row[0]
          district_number = row[0]
          district_number = "NULL" unless district_number.count("a-zA-Z1234567890") > 0
        rescue Exception => e
          district_number = "NULL"
        end

        begin
          district_name = "'#{row[1].gsub("'", "\\\\'")}'"
          district_name = "NULL" unless district_name.count("a-zA-Z1234567890") > 0
        rescue Exception => e
          district_name = "NULL"
        end

        begin
          enrollments = row[2]
          enrollments = "NULL" unless enrollments.count("a-zA-Z1234567890") > 0
        rescue Exception => e
          enrollments = "NULL"
        end

        begin
          absent_21_days_or_over = row[3]
          absent_21_days_or_over = "NULL" unless absent_21_days_or_over.count("a-zA-Z1234567890") > 0
        rescue Exception => e
          absent_21_days_or_over = "NULL"
        end

        begin
          percent_absent_21_or_more_days = row[4].gsub(",", ".").to_f
            # percent_absent_21_or_more_days = "NULL" unless percent_absent_21_or_more_days.count("a-zA-Z1234567890") > 0
        rescue Exception => e
          percent_absent_21_or_more_days = "NULL"
        end

        district_hash = {
            'district_number': district_number,
            'district_name': district_name,
            'enrollments': enrollments,
            'absent_21_days_or_over': absent_21_days_or_over,
            'percent_absent_21_or_more_days': percent_absent_21_or_more_days,
            'data_source_url': "'http://www.fldoe.org/core/fileparse.php/7584/urlt/1516ABS21DAYSchool.xls'",
            'source_as_google_spreadsheet_url': "'https://drive.google.com/open?id=1GOUnb9rtWYxnMjHwsixOXf5pZTub_5cvzMLBLMz9wMA'",
            'll_scrape_dev_name': "'Krasno Oleg'",
            'academic_year': "'2015-16'"
        }
        save_districts_to_db(district_hash)
      end
      index += 1
    end
  end
end
