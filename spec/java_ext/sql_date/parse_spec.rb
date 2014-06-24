require File.expand_path('../../../shared/fixtures', __FILE__)
require 'jactive_support/java_ext/sql_date/localize'

setup_date_translations
describe "java::sql::Date.parse" do
  it "parses sql date with format" do
    date = java::sql::Date.parse('2007', format: 'yyyy')
    date.localize.should == '01/01/2007'
  end

  it "localizes sql date with default date format" do
    date = java::sql::Date.parse('Oct 12, 2007', format: '')
    date.localize.should == '12/10/2007'
  end
end
