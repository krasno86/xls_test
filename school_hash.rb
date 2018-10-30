require_relative 'tables/schools_saver'

def create_s2_hash(file_name, year, data_source_url, source_as_google_spreadsheet_url)
  index = 0
  CSV.foreach("/home/krasno_o/work/xls_test/#{file_name}") do |row|
    if index > 4
      begin
        district_number = "'#{row[0].gsub("'", "\\\\'")}'"
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
        course_number = "'#{row[2].gsub("'", "\\\\'")}'"
        course_number = "NULL" unless course_number.count("a-zA-Z1234567890") > 0
      rescue Exception => e
        course_number = "NULL"
      end

      begin
        course_name = "'#{row[3].gsub("'", "\\\\'")}'"
        course_name = "NULL" unless course_name.count("a-zA-Z1234567890") > 0
      rescue Exception => e
        course_name = "NULL"
      end

      begin
        course_enrollment = row[4]
        course_enrollment = "NULL" unless course_enrollment.count("a-zA-Z1234567890") > 0
      rescue Exception => e
        course_enrollment = "NULL"
      end

      district_hash = {
          'district_number': district_number,
          'district_name': district_name,
          'course_name': course_name,
          'course_number': course_number,
          'course_enrollment': course_enrollment,
          'data_source_url': data_source_url,
          'source_as_google_spreadsheet_url': source_as_google_spreadsheet_url,
          'll_scrape_dev_name': "'Krasno Oleg'",
          'academic_year': year
      }
      save_s2_to_db(district_hash)
    end
    index += 1
  end
end