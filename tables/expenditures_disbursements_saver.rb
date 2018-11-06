require 'mysql2'

def save_expenditures_disbursements_to_db(expenditures_disbursements_hash)
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
    client.query("INSERT INTO oleg_krasno_ilearn_expenditures_disbursements (
                                    district_number,
                                    district_name,
                                    instruction_amount,
                                    general_administration_amount,
                                    support_services_amount,
                                    other_amount,
                                    total_amount,
                                    data_source_url,
                                    scrape_dev)
          VALUES (#{expenditures_disbursements_hash['district_number']},
                  #{expenditures_disbursements_hash['district_name']},
                  #{expenditures_disbursements_hash['instruction_amount']},
                  #{expenditures_disbursements_hash['general_administration_amount']},
                  #{expenditures_disbursements_hash['support_services_amount']},
                  #{expenditures_disbursements_hash['other_amount']},
                  #{expenditures_disbursements_hash['total_amount']},
                  'http://webprod1.isbe.net/ILEARN/Content/SearchData',
                  'Oleg Krasno');")
    p "-" * 150
    p "SAVED_expenditures_disbursements"
    p "=" * 150
  rescue Exception => e
    p "############################EXCEPTION_SQL_SAVE_expenditures_disbursements#########################"
    p e
    p expenditures_disbursements_hash
  end
  client.close
end
