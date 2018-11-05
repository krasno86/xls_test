require 'rubygems'
require 'open-uri'
require 'spreadsheet'
require 'mysql2'
require 'csv'
require 'date'
require 'nokogiri'
require 'capybara'
require 'capybara/dsl'
require 'capybara-webkit'
require 'selenium-webdriver'
require_relative 'tables/districts_saver'


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

# profile = Selenium::WebDriver::Firefox::Profile.new
# proxy = Selenium::WebDriver::Proxy.new(http: "23.23.23.23:3128")
# profile.proxy = proxy
# profile['general.useragent.override'] = 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:62.0) Gecko/20100101 Firefox/62.0'
# options = Selenium::WebDriver::Firefox::Options.new(profile: profile)
# driver = Selenium::WebDriver.for :firefox, options: options
#
# driver.navigate.to "http://webprod1.isbe.net/ILEARN/Content/SearchData"
#
# element = driver.find_element(id: '#submit')
# p element

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :firefox)
end
Capybara.javascript_driver = :firefox
Capybara.configure do |config|
  config.default_max_wait_time = 10 # seconds
  config.default_driver = :selenium
end
# Visit
browser = Capybara.current_session
driver = browser.driver.browser
browser.visit "http://webprod1.isbe.net/ILEARN/Content/SearchData"
browser.find('#Submit').click




doc = Nokogiri::HTML(driver.page_source)
index = 0
array = []


doc.css('tbody tr').each do |th|
  break if !doc.css('.PagedList-skipToNext')
    if index > 0

    district_hash = {}
    # district_hash.id = th.css('td').first.text.to_i
    # district_hash.name = th.css('td')[1].text.to_s.gsub("\n",'').strip

    link = 'http://webprod1.isbe.net'.concat(th.css('td a')[0]["href"])
    browser.visit link
    page = Nokogiri::HTML(driver.page_source)
    number_and_name = page.css('#DistrictInfo').text.gsub('District : ','')
    district_hash['district_number'] = number_and_name.split[0].to_i
    district_hash['district_name'] = "'#{number_and_name.split.slice(2..-1).join(' ')}'"
    district_hash['superintendent'] = "'#{page.css('.col-md-offset-4 p')[0].text.gsub("Superintendent:", "").strip}'"
    district_hash['address'] = "'#{page.css('.col-md-offset-4 p')[1].text.gsub("Address:", "").strip}'"
    district_hash['phone'] = "'#{page.css('.col-md-offset-4 p')[2].text.gsub("Phone:", "").strip}'"
    district_hash['district_type'] = "'#{page.css('.col-md-offset-4 p')[3].text.gsub("\n","").gsub("District Type:", "").strip}'"
    save_district_to_db district_hash
    end
  
  index += 1
end

browser.visit "http://webprod1.isbe.net/ILEARN/Content/SearchData"
browser.find('.PagedList-skipToNext a').click


# browser.visit "http://webprod1.isbe.net/ILEARN/Content/displayData?RCDTSeclected=01001001026&District=Payson%20CUSD%201"
# doc = Nokogiri::HTML(driver.page_source)
# p superintendent = doc.css('.col-md-offset-4 p')[0].text.gsub("Superintendent:", "").strip
# p address = doc.css('.col-md-offset-4 p')[1].text.gsub("Superintendent:", "").strip
# p phone = doc.css('.col-md-offset-4 p')[2].text.gsub("Phone:", "").strip
# p district_type = doc.css('.col-md-offset-4 p')[3].text.gsub("\n",'').gsub("District Type:", "").strip




# doc.css('.col-md-offset-4').each do |f|
#   p '----------------------'
#   p f.text
# end

# browser.find('table tbody tr:nth-child(2) a').click
# sleep(2)
# doc = Nokogiri::HTML(driver.page_source)
# p doc.css('#DistrictInfo').text