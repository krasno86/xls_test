require_relative 'district_hash'

def get_district_params(file_name)
  year = "'2016-17'"
  data_source_url = "'http://www.fldoe.org/accountability/data-sys/edu-info-accountability-services/pk-12-public-school-data-pubs-reports/archive.stml'"
  source_as_google_spreadsheet_url = "''"
  create_district_hash(file_name, year, data_source_url, source_as_google_spreadsheet_url)
end
