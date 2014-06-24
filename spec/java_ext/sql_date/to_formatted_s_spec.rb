require File.expand_path('../../../shared/fixtures', __FILE__)
require 'jactive_support/java_ext/sql_date/conversions'

describe "java::sql::Date#to_formatted_s" do
  it "formats using locale format" do
    setup_date_translations
    date = java::sql::Date.new(1192140000000)
    date.to_formatted_s(:i18n).should == '12/10/2007'
  end
end
