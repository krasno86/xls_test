require 'rubygems'
require 'open-uri'
require 'spreadsheet'
require 'mysql2'
require 'csv'
require_relative 'tables/schools_saver'

# client =  Mysql2::Client.new(host: 'localhost', username: 'root', password: '123456', database: 'applicant_tests')

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
  # index = 0

  # created_at = DateTime.now
  # updated_at = DateTime.now
  # data_source_url = 'http://www.fldoe.org/core/fileparse.php/7584/urlt/1516ABS21DAYSchool.xls'
  # source_as_google_spreadsheet_url = 'https://drive.google.com/open?id=1GOUnb9rtWYxnMjHwsixOXf5pZTub_5cvzMLBLMz9wMA'
  # ll_scrape_dev_name = 'Krasno Oleg'
  # academic_year = ''
  #
  # district_number = ''
  # district_name = ''
  # school_number = ''
  # school_name = ''
  # enrollments = ''
  # absent_21_days_or_over = ''
  # percent_absent_21_or_more_days = ''
  p '000000000000'
  if file_name == 'csv_files/1516ABS21DAYSchool.csv'
    index = 0
    CSV.foreach("/home/krasno_o/work/xls_test/#{file_name}") do |row|
      # row if ![nil,"School Name"].include?(row[3])
      if index > 2
        begin
          district_number = "'#{row[0].gsub("'", "\\\\'")}'"
          # district_number = row[0] if row[0].length < 4
          district_number = row[0]
          district_number = "NULL" unless district_number.count("a-zA-Z1234567890") > 0
        rescue Exception => e
          district_number = "NULL"
        end

        begin
          district_name = "'#{row[0].gsub("'", "\\\\'")}'"
          district_name = row[1]
          district_name = "NULL" unless district_name.count("a-zA-Z1234567890") > 0
        rescue Exception => e
          district_name = "NULL"
        end

        begin
          school_number = row[2]
          school_number = "NULL" unless school_number.count("a-zA-Z1234567890") > 0
        rescue Exception => e
          school_number = "NULL"
        end

        begin
          school_name = row[3]
          school_name = "NULL" unless school_name.count("a-zA-Z1234567890") > 0
        rescue Exception => e
          school_name = "NULL"
        end

        begin
          absent_21_days_or_over = row[4]
          absent_21_days_or_over = "NULL" unless absent_21_days_or_over.count("a-zA-Z1234567890") > 0
        rescue Exception => e
          absent_21_days_or_over = "NULL"
        end

        begin
          percent_absent_21_or_more_days = row[5]
          percent_absent_21_or_more_days = "NULL" unless percent_absent_21_or_more_days.count("a-zA-Z1234567890") > 0
        rescue Exception => e
          percent_absent_21_or_more_days = "NULL"
        end

        schools_hash = {
          'district_number': district_number,
          'district_name': district_name,
          'school_number': school_number,
          'school_name': school_name,
          'enrollments': '',
          'absent_21_days_or_over': absent_21_days_or_over,
          'percent_absent_21_or_more_days': percent_absent_21_or_more_days,

          'created_at': DateTime.now,
          'updated_at': DateTime.now,
          'data_source_url': 'http://www.fldoe.org/core/fileparse.php/7584/urlt/1516ABS21DAYSchool.xls',
          'source_as_google_spreadsheet_url': 'https://drive.google.com/open?id=1GOUnb9rtWYxnMjHwsixOXf5pZTub_5cvzMLBLMz9wMA',
          'll_scrape_dev_name': 'Krasno Oleg',
          'academic_year': ''
        }
        p '222222222222222222222222'
        save_schools_to_db(schools_hash)
      end
      index += 1
    end
  end

  # if file_name == '1516ABS21DAYSDistrict.csv'
  #   CSV.parse("/home/krasno_o/work/xls_test/#{file_name}") do |row|
  #     begin
  #       district_number = row[0] if row[0].length < 4
  #       district_number = "NULL" unless district_number.count("a-zA-Z1234567890") > 0
  #     rescue Exception => e
  #       district_number = "NULL"
  #     end
  #
  #     begin
  #       district_name = row[0] if row[0].length < 4
  #       district_name = "NULL" unless district_name.count("a-zA-Z1234567890") > 0
  #     rescue Exception => e
  #       district_name = "NULL"
  #     end
  #
  #     begin
  #       enrollments = row[0] if row[0].length < 4
  #       enrollments = "NULL" unless school_number.count("a-zA-Z1234567890") > 0
  #     rescue Exception => e
  #       enrollments = "NULL"
  #     end
  #
  #     begin
  #       absent_21_days_or_over = row[0] if row[0].length < 4
  #       absent_21_days_or_over = "NULL" unless absent_21_days_or_over.count("a-zA-Z1234567890") > 0
  #     rescue Exception => e
  #       absent_21_days_or_over = "NULL"
  #     end
  #
  #     begin
  #       percent_absent_21_or_more_days = row[0] if row[0].length < 4
  #       percent_absent_21_or_more_days = "NULL" unless percent_absent_21_or_more_days.count("a-zA-Z1234567890") > 0
  #     rescue Exception => e
  #       percent_absent_21_or_more_days = "NULL"
  #     end
  #   end
  # end
end
