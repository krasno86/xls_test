require_relative 'tables/districts_saver'
require_relative 'tables/receipts_saver'
require_relative 'tables/expenditures_disbursements_saver'
require_relative 'tables/student_info_saver'
require_relative 'tables/tax_information'

def parse_district(page)
  district_hash = {}
  number_and_name = page.css('#DistrictInfo').text.gsub('District : ','')
  district_hash['district_number'] = "'#{number_and_name.split[0]}'"
  district_hash['district_name'] = "'#{number_and_name.split.slice(2..-1).join(' ')}'"
  district_hash['superintendent'] = "'#{page.css('.col-md-offset-4 p')[0].text.gsub("Superintendent:", "").strip}'"
  district_hash['address'] = "'#{page.css('.col-md-offset-4 p')[1].text.gsub("Address:", "").strip}'"
  district_hash['phone'] = "'#{page.css('.col-md-offset-4 p')[2].text.gsub("Phone:", "").strip}'"
  district_hash['district_type'] = "'#{page.css('.col-md-offset-4 p')[3].text.gsub("\n","").gsub("District Type:", "").strip}'"
  save_district_to_db district_hash
end

def parse_receipts_revenues(page)
  receipt_hash = {}
  number_and_name = page.css('#DistrictInfo').text.gsub('District : ','')
  receipt_hash['district_number'] = "'#{number_and_name.split[0]}'"
  receipt_hash['district_name'] = "'#{number_and_name.split.slice(2..-1).join(' ')}'"
  receipt_hash['state_amount'] = page.css('#collapseOne .table tr:nth-child(2) td:nth-child(2)')[0].text.gsub('$','').gsub(',','').strip.to_i
  receipt_hash['local_amount'] = page.css('#collapseOne .table tr:nth-child(3) td:nth-child(2)')[0].text.gsub('$','').gsub(',','').strip.to_i
  receipt_hash['federal_amount'] = page.css('#collapseOne .table tr:nth-child(4) td:nth-child(2)')[0].text.gsub('$','').gsub(',','').strip.to_i
  receipt_hash['total_amount'] = page.css('#collapseOne .table tr:nth-child(5) td:nth-child(2)')[0].text.gsub('$','').gsub(',','').strip.to_i
  save_receipt_to_db receipt_hash
end

def parse_expenditures_disbursements(page)
  expenditures_disbursements_hash = {}
  number_and_name = page.css('#DistrictInfo').text.gsub('District : ','')
  expenditures_disbursements_hash['district_number'] = "'#{number_and_name.split[0]}'"
  expenditures_disbursements_hash['district_name'] = "'#{number_and_name.split.slice(2..-1).join(' ')}'"
  expenditures_disbursements_hash['instruction_amount'] = page.css('#collapseOne .table:last tr:nth-child(2) td:nth-child(2)')[0].text.gsub('$','').gsub(',','').strip.to_i
  expenditures_disbursements_hash['general_administration_amount'] = page.css('#collapseOne .table:last tr:nth-child(3) td:nth-child(2)')[0].text.gsub('$','').gsub(',','').strip.to_i
  expenditures_disbursements_hash['support_services_amount'] = page.css('#collapseOne .table:last tr:nth-child(4) td:nth-child(2)')[0].text.gsub('$','').gsub(',','').strip.to_i
  expenditures_disbursements_hash['other_amount'] = page.css('#collapseOne .table:last tr:nth-child(5) td:nth-child(2)')[0].text.gsub('$','').gsub(',','').strip.to_i
  expenditures_disbursements_hash['total_amount'] = page.css('#collapseOne .table:last tr:nth-child(6) td:nth-child(2)')[0].text.gsub('$','').gsub(',','').strip.to_i
  save_expenditures_disbursements_to_db expenditures_disbursements_hash
end

def parse_per_student_info(page)
  student_info_hash = {}
  number_and_name = page.css('#DistrictInfo').text.gsub('District : ','')
  student_info_hash['district_number'] = "'#{number_and_name.split[0]}'"
  student_info_hash['district_name'] = "'#{number_and_name.split.slice(2..-1).join(' ')}'"
  student_info_hash['9_month_avg_daily_attendance'] = page.css('#collapseTwo .table tr:nth-child(2) td:nth-child(2)')[0].text.gsub('$','').gsub(',','').strip.to_i
  student_info_hash['statewide_ADA'] = page.css('#collapseTwo .table tr:nth-child(3) td:nth-child(2)')[0].text.gsub('$','').gsub(',','').strip.to_i
  student_info_hash['net_operating_expense'] = page.css('#collapseTwo .table:nth-child(2) tr:nth-child(2) td:nth-child(2)')[0].text.gsub('$','').gsub(',','').strip.to_i
  student_info_hash['operating_expense_per_pupil'] = page.css('#collapseTwo .table:nth-child(2) tr:nth-child(3) td:nth-child(2)')[0].text.gsub('$','').gsub(',','').strip.to_i
  student_info_hash['statewide_OEPP_rank'] = page.css('#collapseTwo .table:nth-child(2) tr:nth-child(4) td:nth-child(2)')[0].text.gsub('$','').gsub(',','').strip.to_i
  student_info_hash['statewide_OEPP'] = page.css('#collapseTwo .table:nth-child(2) tr:nth-child(5) td:nth-child(2)')[0].text.gsub('$','').gsub(',','').strip.to_i
  student_info_hash['allowance_for_tuition_computation'] = page.css('#collapseTwo .table:nth-child(3) tr:nth-child(2) td:nth-child(2)')[0].text.gsub('$','').gsub(',','').strip.to_i
  student_info_hash['per_capita_tuition_charge_PCTC'] = page.css('#collapseTwo .table:nth-child(3) tr:nth-child(3) td:nth-child(2)')[0].text.gsub('$','').gsub(',','').strip.to_i
  student_info_hash['statewide_PCTC_rank'] = page.css('#collapseTwo .table:nth-child(3) tr:nth-child(4) td:nth-child(2)')[0].text.gsub('$','').gsub(',','').strip.to_i
  student_info_hash['statewide_PCTC'] = page.css('#collapseTwo .table:nth-child(3) tr:nth-child(5) td:nth-child(2)')[0].text.gsub('$','').gsub(',','').strip.to_i
  save_student_info_to_db student_info_hash
end

def parse_tax_information(page)
  tax_information_hash = {}
  number_and_name = page.css('#DistrictInfo').text.gsub('District : ','')
  tax_information_hash['district_number'] = "'#{number_and_name.split[0]}'"
  tax_information_hash['district_name'] = "'#{number_and_name.split.slice(2..-1).join(' ')}'"
  tax_information_hash['real_eav'] = page.css('#collapseThree .table tr:nth-child(2) td:nth-child(2)')[0].text.gsub(',','').strip.to_i
  tax_information_hash['reav_per_pupil'] = page.css('#collapseThree .table tr:nth-child(3) td:nth-child(2)')[0].text.gsub(',','').strip.to_i
  tax_information_hash['statewide_eavpp_rank'] = page.css('#collapseThree .table tr:nth-child(4) td:nth-child(2)')[0].text.strip.to_i
  tax_information_hash['formula_type'] = "'#{page.css('#collapseThree .table tr:nth-child(5) td:nth-child(2)')[0].text}'"
  tax_information_hash['total_tax_rate'] = page.css('#collapseThree .table:nth-child(2) tr:nth-child(2) td:nth-child(2)')[0].text.strip.to_f
  tax_information_hash['statewide_ttr_rank'] = page.css('#collapseThree .table:nth-child(2) tr:nth-child(3) td:nth-child(2)')[0].text.strip.to_i
  tax_information_hash['operating_tax_rate'] = page.css('#collapseThree .table:nth-child(2) tr:nth-child(4) td:nth-child(2)')[0].text.strip.to_f
  tax_information_hash['statewide_otr_rank'] = page.css('#collapseThree .table:nth-child(2) tr:nth-child(5) td:nth-child(2)')[0].text.strip.to_i
  save_tax_information_to_db tax_information_hash
end
