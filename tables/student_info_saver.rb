require 'mysql2'

def save_student_info_to_db(student_info_hash)
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
    client.query("INSERT INTO oleg_krasno_ilearn_per_student_info (
                                    district_number,
                                    district_name,
                                    9_month_avg_daily_attendance,
                                    statewide_ADA,
                                    net_operating_expense,
                                    operating_expense_per_pupil,
                                    statewide_OEPP_rank,
                                    statewide_OEPP,
                                    allowance_for_tuition_computation,
                                    per_capita_tuition_charge_PCTC,
                                    statewide_PCTC_rank,
                                    statewide_PCTC,
                                    data_source_url,
                                    scrape_dev)
          VALUES (#{student_info_hash['district_number']},
                  #{student_info_hash['district_name']},
                  #{student_info_hash['9_month_avg_daily_attendance']},
                  #{student_info_hash['statewide_ADA']},
                  #{student_info_hash['net_operating_expense']},
                  #{student_info_hash['operating_expense_per_pupil']},
                  #{student_info_hash['statewide_OEPP_rank']},
                  #{student_info_hash['statewide_OEPP']},
                  #{student_info_hash['allowance_for_tuition_computation']},
                  #{student_info_hash['per_capita_tuition_charge_PCTC']},
                  #{student_info_hash['statewide_PCTC_rank']},
                  #{student_info_hash['statewide_PCTC']},
                  'http://webprod1.isbe.net/ILEARN/Content/SearchData',
                  'Oleg Krasno');")
    p "-" * 150
    p "SAVED_student_info"
    p "=" * 150
  rescue Exception => e
    p "############################EXCEPTION_SQL_SAVE_student_info#########################"
    p e
    p student_info_hash
  end
  client.close
end
