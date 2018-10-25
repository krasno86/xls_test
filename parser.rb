require 'rubygems'
require 'open-uri'
require 'spreadsheet'
require 'mysql2'
require 'csv'
require_relative 'school_hash'
require_relative 'district_hash'
require 'date'

# table1 = Spreadsheet.open '/home/krasno_o/Загрузки/1516ABS21DAYSchool.xls'
# sheet1 = table1.worksheet 0
# sheet1.each do |row|
#   p row
# end

# url = 'http://www.fldoe.org/core/fileparse.php/7584/urlt/1516ABS21DAYSDistrict.xls'
# doc = Spreadsheet.open (open(url))
# sheet1 = doc.worksheet 0
# sheet1.each do |row|
#   p row
# end

old_names_arr = Dir["xls_files/*"]

# old_names_arr.each do |old_file_name|
#   new_file_name = "#{old_file_name.gsub("xls_files/", "").gsub(".xls", "")}.csv"
#   %x(ssconvert ~/work/xls_test/#{old_file_name} ~/work/xls_test/csv_files/#{new_file_name})
# end

csv_files_names = Dir["csv_files/*"]

csv_files_names.each do |file_name|

  if file_name.include? 'District' || 'district'
    get_district_params file_name
  else
    get_school_params file_name
  end

  create_district_hash(file_name, year, data_source_url, source_as_google_spreadsheet_url)
end

def get_district_params file_name
  case file_name
  when file_name.include? '1213'
    year = "'2012-13'"
    data_source_url = "'http://www.fldoe.org/core/fileparse.php/7584/urlt/0069362-absent1213district.xls'"
    source_as_google_spreadsheet_url = "'https://drive.google.com/file/d/1DBmyG7_YNvj3tNtWBISSxCKMcq3Bmtau/view?usp=sharing'"
  when file_name.include? '2013-14'
    year = "'2013-14'"
    data_source_url = "'http://www.fldoe.org/core/fileparse.php/7584/urlt/2013-14-ABS21DAYS-District-Web.xls'"
    source_as_google_spreadsheet_url = "'https://drive.google.com/file/d/1LuVXq6jlYMm3iLHyn_7SdGCyeVLIF4FR/view?usp=sharing'"
  when file_name.include? '1415'
    year = "'2014-15'"
    data_source_url = "'http://www.fldoe.org/core/fileparse.php/7584/urlt/1415ABS21DAYSDistrict.xls'"
    source_as_google_spreadsheet_url = "'https://drive.google.com/file/d/1WRxJfjoD5u9UhXfw3JhjwPKDsliIRR77/view?usp=sharing'"
  when file_name.include? '1516'
    year = "'2015-16'"
    data_source_url = "'http://www.fldoe.org/core/fileparse.php/7584/urlt/1516ABS21DAYSDistrict.xls'"
    source_as_google_spreadsheet_url = "'https://drive.google.com/file/d/1LuVXq6jlYMm3iLHyn_7SdGCyeVLIF4FR/view?usp=sharing'"
  end
end

def get_school_params file_name
  case file_name
    when file_name.include? '1213'
      year = "'2012-13'"
      data_source_url = "'http://www.fldoe.org/core/fileparse.php/7584/urlt/0069362-absent1213.xls'"
      source_as_google_spreadsheet_url = "'https://drive.google.com/file/d/1GFweJPwhI3F7RuFGPWtV693t86yebjHD/view?usp=sharing'"
    when file_name.include? '2013-14'
      year = "'2013-14'"
      data_source_url = "'http://www.fldoe.org/core/fileparse.php/7584/urlt/2013-14-ABS21DAYS-School-Web.xls'"
      source_as_google_spreadsheet_url = "'https://drive.google.com/file/d/1Jn9kQLf3rG1uyLIXajAfmO1-QoQ88woo/view?usp=sharing'"
    when file_name.include? '1415'
      year = "'2014-15'"
      data_source_url = "'http://www.fldoe.org/core/fileparse.php/7584/urlt/1415ABS21DAYSchool.xls'"
      source_as_google_spreadsheet_url = "'https://drive.google.com/file/d/1CGdEa1iiDxiF7r56oiGzUVpZCvec7Zxo/view?usp=sharing'"
    when file_name.include? '1516'
      year = "'2015-16'"
      data_source_url = "'http://www.fldoe.org/core/fileparse.php/7584/urlt/1516ABS21DAYSchool.xls'"
      source_as_google_spreadsheet_url = "'https://drive.google.com/file/d/1zkwPy5ZuufIl17aV54ya9T-lO3dJfuHz/view?usp=sharing'"
  end
end

# csv_files_names.each do |file_name|
#
#   if file_name == 'csv_files/1516ABS21DAYSchool.csv'
#     create_school_hash(file_name)
#   elsif file_name == 'csv_files/1516ABS21DAYSDistrict.csv'
#     create_district_hash(file_name)
#   end
# end
