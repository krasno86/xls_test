require 'mysql2'

def save_schools_to_db(schools_hash)
  p '33333333333333333333333333333333333'
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
    client.query("INSERT INTO oleg_krasno_florida_edu_school_absent_21_plus_days (
                                    district_number,
                                    district_name,
                                    school_number,
                                    school_name,
                                    enrollments,
                                    absent_21_days_or_over,
                                    percent_absent_21_or_more_days,
                                    created_at,
                                    updated_at,
                                    data_source_url,
                                    source_as_google_spreadsheet_url,
                                    ll_scrape_dev_name,
                                    academic_year)
          VALUES (#{schools_hash[:district_number]},
                  #{schools_hash[:district_name]},
                  #{schools_hash[:school_number]},
                  #{schools_hash[:school_name]},
                  #{schools_hash[:enrollments]},
                  #{schools_hash[:absent_21_days_or_over]},
                  #{schools_hash[:percent_absent_21_or_more_days]},

                  #{schools_hash[:created_at]},
                  #{schools_hash[:updated_at]},
                  #{schools_hash[:data_source_url]},
                  #{schools_hash[:source_as_google_spreadsheet_url]},
                  #{schools_hash[:ll_scrape_dev_name]},
                  #{schools_hash[:academic_year]});")
    p "-" * 150
    p "SAVED_SCHOOLS"
    p "=" * 150
  rescue Exception => e
    p "############################EXCEPTION_SQL_SAVE_EMPLOYEE#########################"
    p e
    p schools_hash
  end
  client.close
end
