require_relative 'school_hash'

def get_s2_params(file_name)
  case true
  when file_name.include?('1213')
    year = "'2012-13'"
  when file_name.include?('1314')
    year = "'2013-14'"
  when file_name.include?('1415')
    year = "'2014-15'"
  when file_name.include?('1516')
    year = "'2015-16'"
  when file_name.include?('1516')
    year = "'2016-17'"
  end

  data_source_url = "'http://www.fldoe.org/accountability/data-sys/edu-info-accountability-services/pk-12-public-school-data-pubs-reports/archive.stml'"
  source_as_google_spreadsheet_url = "''"

  create_s2_hash(file_name, year, data_source_url, source_as_google_spreadsheet_url)
end