require_relative 'school_hash'

def get_school_params(file_name)
  case true
  when file_name.include?('2013-14')
    year = "'2013-14'"
    data_source_url = "'http://www.fldoe.org/core/fileparse.php/7584/urlt/2013-14-Average-Daily-Attendance-13145-FINAL-31915-School.xls'"
  when file_name.include?('1415')
    year = "'2014-15'"
    data_source_url = "'http://www.fldoe.org/core/fileparse.php/7584/urlt/ADAADMSchl1415.xlsx'"
  when file_name.include?('1516')
    year = "'2015-16'"
    data_source_url = "'http://www.fldoe.org/core/fileparse.php/7584/urlt/ADAADMSchl1516.xls'"
  end

  source_as_google_spreadsheet_url = "'https://docs.google.com/spreadsheets/d/1ofOkRFKcWv-6QqfNsLmgje45DiBl72Hf6zfbcakP3I0/edit?usp=sharing'"
  create_school_hash(file_name, year, data_source_url, source_as_google_spreadsheet_url)
end