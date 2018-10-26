require_relative 'school_hash'

def get_school_params(file_name)
  case true
  when file_name.include?('1213')
    year = "'2012-13'"
    data_source_url = "'http://www.fldoe.org/core/fileparse.php/7584/urlt/0069362-absent1213.xls'"
    source_as_google_spreadsheet_url = "'https://drive.google.com/file/d/1YAcsuw9YE6EFpljnbnLPDEJmcl-XDkrc/view?usp=sharing'"
  when file_name.include?('2013-14')
    year = "'2013-14'"
    data_source_url = "'http://www.fldoe.org/core/fileparse.php/7584/urlt/2013-14-ABS21DAYS-School-Web.xls'"
    source_as_google_spreadsheet_url = "'https://drive.google.com/file/d/1po7RpwR7NWpOu7JHS7j45Uv6iqkhq-Mw/view?usp=sharing'"
  when file_name.include?('1415')
    year = "'2014-15'"
    data_source_url = "'http://www.fldoe.org/core/fileparse.php/7584/urlt/1415ABS21DAYSchool.xls'"
    source_as_google_spreadsheet_url = "'https://drive.google.com/file/d/15EPo2wk0JuRUpEurgpICmQKsRS5Oi9Na/view?usp=sharing'"
  when file_name.include?('1516')
    year = "'2015-16'"
    data_source_url = "'http://www.fldoe.org/core/fileparse.php/7584/urlt/1516ABS21DAYSchool.xls'"
    source_as_google_spreadsheet_url = "'https://drive.google.com/file/d/1WoR3ysUGOMhxO6UkqUCcccENEzm4fRce/view?usp=sharing'"
  end

  create_school_hash(file_name, year, data_source_url, source_as_google_spreadsheet_url)
end