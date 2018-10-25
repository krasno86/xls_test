require 'mysql2'

def save_districts_to_db(district_hash)
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
    client.query("INSERT INTO oleg_krasno_florida_edu_district_absent_21_plus_days (
                                    district_number,
                                    district_name,
                                    enrollments,
                                    absent_21_days_or_over,
                                    percent_absent_21_or_more_days,
                                    data_source_url,
                                    source_as_google_spreadsheet_url,
                                    ll_scrape_dev_name,
                                    academic_year)
          VALUES (#{district_hash[:district_number]},
                  #{district_hash[:district_name]},
                  #{district_hash[:enrollments]},
                  #{district_hash[:absent_21_days_or_over]},
                  #{district_hash[:percent_absent_21_or_more_days]},
                  #{district_hash[:data_source_url]},
                  #{district_hash[:source_as_google_spreadsheet_url]},
                  #{district_hash[:ll_scrape_dev_name]},
                  #{district_hash[:academic_year]});")
    p "-" * 150
    p "SAVED_DISTRICTS"
    p "=" * 150
  rescue Exception => e
    p "############################EXCEPTION_SQL_SAVE_EMPLOYEE#########################"
    p e
    p district_hash
  end
  client.close
end
