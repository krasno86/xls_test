require 'mysql2'

def save_receipt_to_db(receipt_hash)
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
    client.query("INSERT INTO oleg_krasno_ilearn_receipts_revenues (
                                    district_number,
                                    district_name,
                                    state_amount,
                                    local_amount,
                                    federal_amount,
                                    total_amount,
                                    data_source_url,
                                    scrape_dev)
          VALUES (#{receipt_hash['district_number']},
                  #{receipt_hash['district_name']},
                  #{receipt_hash['state_amount']},
                  #{receipt_hash['local_amount']},
                  #{receipt_hash['federal_amount']},
                  #{receipt_hash['total_amount']},
                  'http://webprod1.isbe.net/ILEARN/Content/SearchData',
                  'Oleg Krasno');")
    p "-" * 150
    p "SAVED_Receipts_Revenues"
    p "=" * 150
  rescue Exception => e
    p "############################EXCEPTION_SQL_SAVE_RECEIPT#########################"
    p e
    p district_hash
  end
  client.close
end
