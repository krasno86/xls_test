require_relative 'tables/districts_saver'

def parse_page(page)
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