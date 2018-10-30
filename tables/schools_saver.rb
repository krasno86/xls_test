require 'mysql2'

def save_s2_to_db(district_hash)
  client = ''

  loop do
    begin
      client = Mysql2::Client.new(host: 'localhost', username: 'root', password: '123456', database: 'applicant_tests')
      break
    rescue Exception => e
      p "##########################EXCEPTION_SQL_CONNECTION##########################"
      p e
    end
  end

  begin
    client.query("INSERT INTO oleg_krasno_florida_edu_course_enroll_by_distr_s2 (
                                    district_number,
                                    district_name,
                                    course_number,
                                    course_name,
                                    course_enrollment,
                                    data_source_url,
                                    source_as_google_spreadsheet_url,
                                    ll_scrape_dev_name,
                                    academic_year)
          VALUES (#{district_hash[:district_number]},
                  #{district_hash[:district_name]},
                  #{district_hash[:course_number]},
                  #{district_hash[:course_name]},
                  #{district_hash[:course_enrollment]},
                  #{district_hash[:data_source_url]},
                  #{district_hash[:source_as_google_spreadsheet_url]},
                  #{district_hash[:ll_scrape_dev_name]},
                  #{district_hash[:academic_year]});")
    p "-" * 150
    p "SAVED_SCHOOLS"
    p "=" * 150
  rescue Exception => e
    p "############################EXCEPTION_SQL_SAVE_SCHOOL#########################"
    p e
    p schools_hash
  end
  client.close
end
