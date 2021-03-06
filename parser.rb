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
require_relative 'parse_page'

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
links = []

begin
  loop do
    doc = Nokogiri::HTML(driver.page_source)
    break if !doc.css('.PagedList-skipToNext')

    doc.css('tbody tr').each do |th|
      html = th.css('td a')[0]
      links << 'http://webprod1.isbe.net'.concat(th.css('td a')[0]["href"]) if html
    end
    browser.find('.PagedList-skipToNext a').click
  end

rescue
  links.each do |link|
    browser.visit link if link.length > 0
    page = Nokogiri::HTML(driver.page_source)
    # parse_district(page)
    # parse_receipts_revenues(page)
    # parse_expenditures_disbursements(page)
    # parse_per_student_info(page)
    parse_tax_information(page)
  end
end
