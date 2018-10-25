require_relative 'tables/schools_saver'


def create_school_hash(file_name)
  index = 0
  CSV.foreach("/home/krasno_o/work/xls_test/#{file_name}") do |row|
    if index > 2
      begin
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
        school_number = row[2]
        school_number = "NULL" unless school_number.count("a-zA-Z1234567890") > 0
      rescue Exception => e
        school_number = "NULL"
      end

      begin
        school_name = "'#{row[3].gsub("'", "\\\\'")}'"
        school_name = "NULL" unless school_name.count("a-zA-Z1234567890") > 0
      rescue Exception => e
        school_name = "NULL"
      end

      begin
        enrollments = row[4]
        enrollments = "NULL" unless enrollments.count("a-zA-Z1234567890") > 0
      rescue Exception => e
        enrollments = "NULL"
      end

      begin
        absent_21_days_or_over = row[5]
        absent_21_days_or_over = "NULL" unless absent_21_days_or_over.count("a-zA-Z1234567890") > 0
      rescue Exception => e
        absent_21_days_or_over = "NULL"
      end

      begin
        percent_absent_21_or_more_days = row[6].gsub(",", ".").to_f
          # percent_absent_21_or_more_days = "NULL" unless percent_absent_21_or_more_days.count("a-zA-Z1234567890") > 0
      rescue Exception => e
        percent_absent_21_or_more_days = "NULL"
      end

      schools_hash = {
          'district_number': district_number,
          'district_name': district_name,
          'school_number': school_number,
          'school_name': school_name,
          'enrollments': enrollments,
          'absent_21_days_or_over': absent_21_days_or_over,
          'percent_absent_21_or_more_days': percent_absent_21_or_more_days,
          'data_source_url': "'http://www.fldoe.org/core/fileparse.php/7584/urlt/1516ABS21DAYSchool.xls'",
          'source_as_google_spreadsheet_url': "'https://drive.google.com/open?id=1GOUnb9rtWYxnMjHwsixOXf5pZTub_5cvzMLBLMz9wMA'",
          'll_scrape_dev_name': "'Krasno Oleg'",
          'academic_year': "'2015-16'"
      }
      save_schools_to_db(schools_hash)
    end
    index += 1
  end
end