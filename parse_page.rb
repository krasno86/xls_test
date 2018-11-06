require_relative 'tables/districts_saver'
require_relative 'tables/receipts_saver'

def parse_district(page)
  district_hash = {}
  number_and_name = page.css('#DistrictInfo').text.gsub('District : ','')
  district_hash['district_number'] = number_and_name.split[0]
  district_hash['district_name'] = "'#{number_and_name.split.slice(2..-1).join(' ')}'"
  district_hash['superintendent'] = "'#{page.css('.col-md-offset-4 p')[0].text.gsub("Superintendent:", "").strip}'"
  district_hash['address'] = "'#{page.css('.col-md-offset-4 p')[1].text.gsub("Address:", "").strip}'"
  district_hash['phone'] = "'#{page.css('.col-md-offset-4 p')[2].text.gsub("Phone:", "").strip}'"
  district_hash['district_type'] = "'#{page.css('.col-md-offset-4 p')[3].text.gsub("\n","").gsub("District Type:", "").strip}'"
  save_district_to_db district_hash
end

def parse_receipt(page)
  receipt_hash = {}
  receipt_hash['state_amount'] = page.css('#collapseOne .table tr:nth-child(2) td:nth-child(2)')[0].text.gsub('$','').gsub(',','').strip.to_i
  receipt_hash['local_amount'] = page.css('#collapseOne .table tr:nth-child(3) td:nth-child(2)')[0].text.gsub('$','').gsub(',','').strip.to_i
  receipt_hash['federal_amount'] = page.css('#collapseOne .table tr:nth-child(4) td:nth-child(2)')[0].text.gsub('$','').gsub(',','').strip.to_i
  receipt_hash['total_amount'] = page.css('#collapseOne .table tr:nth-child(5) td:nth-child(2)')[0].text.gsub('$','').gsub(',','').strip.to_i
  save_receipt_to_db(receipt_hash)
end