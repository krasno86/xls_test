require_relative 'tables/schools_saver'

def create_school_hash(file_name, year, data_source_url, source_as_google_spreadsheet_url)
  index = 0
  CSV.foreach("/home/krasno_o/work/xls_test/#{file_name}") do |row|
    if index > 5
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
        school_number = "'#{row[2].gsub("'", "\\\\'")}'"
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
        days_present = row[4]
        days_present = "NULL" unless days_present.count("a-zA-Z1234567890") > 0
      rescue Exception => e
        days_present = "NULL"
      end

      begin
        days_absent = row[5]
        days_absent = "NULL" unless days_absent.count("a-zA-Z1234567890") > 0
      rescue Exception => e
        days_absent = "NULL"
      end

      begin
        total = row[6]
        total = "NULL" unless total.count("a-zA-Z1234567890") > 0
      rescue Exception => e
        total = "NULL"
      end

      begin
        percent_present = row[7].gsub(",", ".").to_f
      rescue Exception => e
        percent_present = "NULL"
      end

      begin
        average_daily_attendance = row[8]
        average_daily_attendance = "NULL" unless average_daily_attendance.count("a-zA-Z1234567890") > 0
      rescue Exception => e
        average_daily_attendance = "NULL"
      end

      begin
        average_daily_membership = row[9]
        average_daily_membership = "NULL" unless average_daily_membership.count("a-zA-Z1234567890") > 0
      rescue Exception => e
        average_daily_membership = "NULL"
      end

      schools_hash = {
          'district_number': district_number,
          'district_name': district_name,
          'school_number': school_number,
          'school_name': school_name,
          'days_present': days_present,
          'days_absent': days_absent,
          'total': total,
          'percent_present': percent_present,
          'average_daily_attendance': average_daily_attendance,
          'average_daily_membership': average_daily_membership,
          'data_source_url': data_source_url,
          'source_as_google_spreadsheet_url': source_as_google_spreadsheet_url,
          'll_scrape_dev_name': "'Krasno Oleg'",
          'academic_year': year
      }
      save_schools_to_db(schools_hash)
    end
    index += 1
  end
end