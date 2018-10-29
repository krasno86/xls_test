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
    client.query("INSERT INTO oleg_krasno_florida_edu_average_daily_attendance_by_district (
                                    district_number,
                                    district_name,
                                    days_present,
                                    days_absent,
                                    total,
                                    percent_present,
                                    average_daily_attendance,
                                    average_daily_membership,
                                    data_source_url,
                                    source_as_google_spreadsheet_url,
                                    ll_scrape_dev_name,
                                    academic_year)
          VALUES (#{district_hash[:district_number]},
                  #{district_hash[:district_name]},
                  #{district_hash[:days_present]},
                  #{district_hash[:days_absent]},
                  #{district_hash[:total]},
                  #{district_hash[:percent_present]},
                  #{district_hash[:average_daily_attendance]},
                  #{district_hash[:average_daily_membership]},
                  #{district_hash[:data_source_url]},
                  #{district_hash[:source_as_google_spreadsheet_url]},
                  #{district_hash[:ll_scrape_dev_name]},
                  #{district_hash[:academic_year]});")
    p "-" * 150
    p "SAVED_DISTRICTS"
    p "=" * 150
  rescue Exception => e
    p "############################EXCEPTION_SQL_SAVE_DISTRICT#########################"
    p e
    p district_hash
  end
  client.close
end
