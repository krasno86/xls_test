require_relative 'tables/districts_saver'


def create_district_hash(file_name, year, data_source_url, source_as_google_spreadsheet_url)
  index = 0
  CSV.foreach("/home/krasno_o/work/xls_test/#{file_name}") do |row|
    if index > 2
      begin
        course_number = "'#{row[0].gsub("'", "\\\\'")}'"
        course_number = "NULL" unless course_number.count("a-zA-Z1234567890") > 0
      rescue Exception => e
        course_number = "NULL"
      end

      begin
        course_name = "'#{row[1].gsub("'", "\\\\'")}'"
        course_name = "NULL" unless course_name.count("a-zA-Z1234567890") > 0
      rescue Exception => e
        course_name = "NULL"
      end

      begin
        enrollment = row[2]
        enrollment = "NULL" unless enrollment.count("a-zA-Z1234567890") > 0
      rescue Exception => e
        enrollment = "NULL"
      end

      district_hash = {
          'course_number': course_number,
          'course_name': course_name,
          'enrollment': enrollment,
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