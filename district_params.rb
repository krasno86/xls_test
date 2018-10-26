require_relative 'district_hash'

def get_district_params(file_name)
  case true
  when file_name.include?('1213')
    year = "'2012-13'"
    data_source_url = "'http://www.fldoe.org/core/fileparse.php/7584/urlt/0069362-absent1213district.xls'"
    source_as_google_spreadsheet_url = "'https://drive.google.com/file/d/17JlrbNfPb8N4flKHdsSXqeegYZnFVN7K/view?usp=sharing'"
  when file_name.include?('2013-14')
    year = "'2013-14'"
    data_source_url = "'http://www.fldoe.org/core/fileparse.php/7584/urlt/2013-14-ABS21DAYS-District-Web.xls'"
    source_as_google_spreadsheet_url = "'https://drive.google.com/file/d/1M_yyGwRpdgdGqUizQoH7nc51790q-phA/view?usp=sharing'"
  when file_name.include?('1415')
    year = "'2014-15'"
    data_source_url = "'http://www.fldoe.org/core/fileparse.php/7584/urlt/1415ABS21DAYSDistrict.xls'"
    source_as_google_spreadsheet_url = "'https://drive.google.com/file/d/1Nz_dH-RD1hHoz0kfwXilJzmXI_5UawEI/view?usp=sharing'"
  when file_name.include?('1516')
    year = "'2015-16'"
    data_source_url = "'http://www.fldoe.org/core/fileparse.php/7584/urlt/1516ABS21DAYSDistrict.xls'"
    source_as_google_spreadsheet_url = "'https://drive.google.com/file/d/1wXGdoa2w0qhSMyn4ykJEz2BHdSrYgNYv/view?usp=sharing'"
  end

  create_district_hash(file_name, year, data_source_url, source_as_google_spreadsheet_url)
end