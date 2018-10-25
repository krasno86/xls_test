require_relative 'tables/districts_saver'


def create_district_hash(file_name, year, data_source_url, source_as_google_spreadsheet_url)
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