require File.expand_path('../../../shared/fixtures', __FILE__)
require 'jactive_support/java_ext/date/localize'

setup_date_translations
describe "java::util::Date#localize" do
  it "localizes date with format" do
    date = java::util::Date.new(1192140000000)
    date.localize(format: 'yyyy').should == '2007'
  end

  it "localizes date with symbol format" do
    date = java::util::Date.new(1192140000000)
    date.localize(format: :short).should == '12. Oct'
  end

  it "localizes date with default date time format" do
    date = java::sql::Date.new(1192140000000)
    date.localize(format: '').should == 'Oct 12, 2007 12:00:00 AM'
  end

  it "fails with missing symbol format" do
    date = java::util::Date.new(1192140000000)
    expect { date.localize(format: :miss) }.to raise_error(I18n::MissingTranslationData)
  end

  it "localizes date with default" do
    date = java::util::Date.new(1192140000000)
    date.localize(default: 'yyyy', locale: :da).should == '2007'
  end

  it "localizes date" do
    date = java::util::Date.new(1192140000000)
    date.localize.should == '00:00:00.000 12/10/2007'
  end

  it "localizes date ignores default when localized" do
    date = java::util::Date.new(1192140000000)
    date.localize(default: 'yyyy').should == '00:00:00.000 12/10/2007'
  end

  it "localizes with time zone" do
    date = java::util::Date.new(1192140000000)
    date.localize(time_zone: 'GMT').should == '22:00:00.000 11/10/2007'
  end

  it "localizes using output format first" do
    date = java::util::Date.new(1192140000000)
    date.localize(format: :default, locale: :sv).should == '00:00:00.000 12-10-07'
    date.localize(locale: :sv).should == '00:00:00.000 12-10-2007'
  end
end