require File.expand_path('../../../shared/fixtures', __FILE__)
require 'jactive_support/java_ext/sql_date/localize'

setup_date_translations
describe "java::sql::Date#localize" do
  it "localizes sql date format" do
    date = java::sql::Date.new(1192140000000)
    date.localize.should == '12/10/2007'
  end

  it "localizes sql date with default date format" do
    date = java::sql::Date.new(1192140000000)
    date.localize(format: '').should == 'Oct 12, 2007'
  end
end