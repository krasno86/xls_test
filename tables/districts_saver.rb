require 'mysql2'

def save_district_to_db(district_hash)
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
    client.query("INSERT INTO oleg_krasno_ilearn_districts (
                                    district_number,
                                    district_name,
                                    superintendent,
                                    address,
                                    phone,
                                    district_type,
                                    data_source_url,
                                    scrape_dev)
          VALUES (#{district_hash['district_number'].to_i},
                  #{district_hash['district_name']},
                  #{district_hash['superintendent']},
                  #{district_hash['address']},
                  #{district_hash['phone']},
                  #{district_hash['district_type']},
                  'http://webprod1.isbe.net/ILEARN/Content/SearchData',
                  'Oleg_Krasno');")
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
