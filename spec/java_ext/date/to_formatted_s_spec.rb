require File.expand_path('../../../shared/fixtures', __FILE__)
require 'jactive_support/java_ext/date/conversions'

describe "java::util::Date#to_formatted_s" do
  it "formats using locale format" do
    setup_date_translations
    date = java::util::Date.new(1192140000000)
    date.to_formatted_s(:i18n).should == '00:00:00.000 12/10/2007'
  end

  it "formats using locale format using locale" do
    setup_date_translations
    date = java::util::Date.new(1192140000000)
    date.to_formatted_s(:i18n, locale: :de).should == '00:00:00.000 12.10.2007'
  end

  it "formats using locale format using locale and time zone" do
    setup_date_translations
    date = java::util::Date.new(1192140000000)
    date.to_formatted_s(:i18n, locale: :de, time_zone: 'GMT').should == '22:00:00.000 11.10.2007'
  end

  it "formats using default format" do
    setup_date_translations
    date = java::util::Date.new(1192140000000)
    date.to_formatted_s(:default).should == 'Oct 12, 2007 12:00:00 AM'
  end

  it "formats using default format using locale" do
    setup_date_translations
    date = java::util::Date.new(1192140000000)
    date.to_formatted_s(:default, locale: :de).should == '12.10.2007 00:00:00'
  end

  it "formats using default format using locale and time zone" do
    setup_date_translations
    date = java::util::Date.new(1192140000000)
    date.to_formatted_s(:default, locale: :de, time_zone: 'GMT').should == '11.10.2007 22:00:00'
  end

  it "formats unknown format using default" do
    setup_date_translations
    date = java::util::Date.new(1192140000000)
    date.to_formatted_s(:muh).should == date.to_default_s
  end

  it "formats db with string" do
    setup_date_translations
    date = java::util::Date.new(1192140000000)
    date.to_formatted_s(:db).should == '2007-10-12 00:00:00.000'
  end

  it "formats httpdate" do
    setup_date_translations
    date = java::util::Date.new(1192140000000)
    date.to_formatted_s(:httpdate).should == 'Thu, 11 Oct 2007 22:00:00 GMT'
  end
end