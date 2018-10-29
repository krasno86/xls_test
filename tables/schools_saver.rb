require 'mysql2'

def save_schools_to_db(schools_hash)
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
    client.query("INSERT INTO oleg_krasno_florida_edu_average_daily_by_school (
                                    district_number,
                                    district_name,
                                    school_number,
                                    school_name,
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
          VALUES (#{schools_hash[:district_number]},
                  #{schools_hash[:district_name]},
                  #{schools_hash[:school_number]},
                  #{schools_hash[:school_name]},
                  #{schools_hash[:days_present]},
                  #{schools_hash[:days_absent]},
                  #{schools_hash[:total]},
                  #{schools_hash[:percent_present]},
                  #{schools_hash[:average_daily_attendance]},
                  #{schools_hash[:average_daily_membership]},
                  #{schools_hash[:data_source_url]},
                  #{schools_hash[:source_as_google_spreadsheet_url]},
                  #{schools_hash[:ll_scrape_dev_name]},
                  #{schools_hash[:academic_year]});")
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
