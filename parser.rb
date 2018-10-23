require 'rubygems'
require 'open-uri'
require 'spreadsheet'
require 'mysql2'
require 'csv'

client =  Mysql2::Client.new(host: 'localhost', username: 'root', password: '123456', database: 'applicant_tests')

# table1 = Spreadsheet.open '/home/krasno_o/Загрузки/1516ABS21DAYSchool.xls'

# url = 'http://www.fldoe.org/core/fileparse.php/7584/urlt/1516ABS21DAYSDistrict.s'
# doc = Spreadsheet.open (open(url))
# sheet1 = table1.worksheet 0
#
# sheet1.each do |row|
#   # p row.size
#   p row[0]
# end

# old_names_arr = Dir["xls_files/*"]
#
# old_names_arr.each do |old_file_name|
#   new_file_name = "#{old_file_name.gsub("xls_files/", "").gsub(".xls", "")}.csv"
#
#   %x( ssconvert ~/work/xls_test/xls_files/#{old_file_name} #{new_file_name})
#   ssconvert ~/work/xls_test/xls_files/#{old_file_name} ~/work/xls_test/csv_files/#{new_file_name})
# end

csv_files_names = Dir["csv_files/*"]

csv_files_names.each do |file_name|
  index = 0

  id = index + 1
  created_at = DateTime.now
  updated_at = DateTime.now
  data_source_url = ''
  source_as_google_spreadsheet_url = ''
  ll_scrape_dev_name = ''
  academic_year = ''


  county_name = ''
  name = ''
  office = ''
  address = ''
  city = ''
  state = ''
  zip = ''
  phone = ''
  fax = ''
  party = ''
  email = ''
  created_by = ""

  CSV.foreach("~/home/krasno_o/work/xls_test/csv_files/#{file_name}") do |row|
    p row.size
    p row[0]
  end
end