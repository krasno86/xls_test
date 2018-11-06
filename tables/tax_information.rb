require 'mysql2'

def save_tax_information_to_db(tax_information_hash)
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
    client.query("INSERT INTO oleg_krasno_ilearn_tax_information (
                                    district_number,
                                    district_name,
                                    real_eav,
                                    reav_per_pupil,
                                    statewide_eavpp_rank,
                                    formula_type,
                                    total_tax_rate,
                                    statewide_ttr_rank,
                                    operating_tax_rate,
                                    statewide_otr_rank,
                                    data_source_url,
                                    scrape_dev)
          VALUES (#{tax_information_hash['district_number']},
                  #{tax_information_hash['district_name']},
                  #{tax_information_hash['real_eav']},
                  #{tax_information_hash['reav_per_pupil']},
                  #{tax_information_hash['statewide_eavpp_rank']},
                  #{tax_information_hash['formula_type']},
                  #{tax_information_hash['total_tax_rate']},
                  #{tax_information_hash['statewide_ttr_rank']},
                  #{tax_information_hash['operating_tax_rate']},
                  #{tax_information_hash['statewide_otr_rank']},
                  'http://webprod1.isbe.net/ILEARN/Content/SearchData',
                  'Oleg Krasno');")
    p "-" * 150
    p "SAVED_tax_information"
    p "=" * 150
  rescue Exception => e
    p "############################EXCEPTION_SQL_SAVE_tax_information#########################"
    p e
    p tax_information_hash
  end
  client.close
end
