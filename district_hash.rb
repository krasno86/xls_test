require_relative 'tables/districts_saver'


def create_district_hash(file_name, year, data_source_url, source_as_google_spreadsheet_url)
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
        days_present = row[2]
        days_present = "NULL" unless days_present.count("a-zA-Z1234567890") > 0
      rescue Exception => e
        days_present = "NULL"
      end

      begin
        days_absent = row[3]
        days_absent = "NULL" unless days_absent.count("a-zA-Z1234567890") > 0
      rescue Exception => e
        days_absent = "NULL"
      end

      begin
        total = row[4]
        total = "NULL" unless total.count("a-zA-Z1234567890") > 0
      rescue Exception => e
        total = "NULL"
      end

      begin
        percent_present = row[5].gsub(",", ".").to_f
        persent_present = "NULL" unless percent_present.count("a-zA-Z1234567890") > 0
      rescue Exception => e
        percent_present = "NULL"
      end

      begin
        average_daily_attendance = row[6]
        average_daily_attendance = "NULL" unless average_daily_attendance.count("a-zA-Z1234567890") > 0
      rescue Exception => e
        average_daily_attendance = "NULL"
      end

      begin
        average_daily_membership = row[7]
        average_daily_membership = "NULL" unless average_daily_membership.count("a-zA-Z1234567890") > 0
      rescue Exception => e
        average_daily_membership = "NULL"
      end

      district_hash = {
          'district_number': district_number,
          'district_name': district_name,
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
      save_districts_to_db(district_hash)
    end
    index += 1
  end
end