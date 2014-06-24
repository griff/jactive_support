require File.expand_path('../../../shared/fixtures', __FILE__)
require 'jactive_support/java_ext/date/localize'

setup_date_translations
describe "java::util::Date.parse" do
  it "parses date with format" do
    date = java::util::Date.parse('2007', format: 'yyyy')
    date.localize.should == '00:00:00.000 01/01/2007'
  end

  it "parses date with symbol format" do
    date = java::util::Date.parse('12. Oct', format: :short)
    date.localize.should == '00:00:00.000 12/10/1970'
  end

  it "fails with missing symbol format" do
    expect { java::util::Date.parse('12. Oct', format: :miss) }.to raise_error(I18n::MissingTranslationData)
  end

  it "parses date with default" do
    date = java::util::Date.parse('2007', default: 'yyyy', locale: :da)
    date.localize.should == '00:00:00.000 01/01/2007'
  end

  it "parses date" do
    date = java::util::Date.parse('00:00:00.000 12/10/2007')
    date.localize.should == '00:00:00.000 12/10/2007'
  end

  it "parses date with suffix" do
    date = java::util::Date.parse('00:00:00.000 12/10/2007muh')
    date.localize.should == '00:00:00.000 12/10/2007'
  end

  it "parses date ignores default when localized" do
    date = java::util::Date.parse('00:00:00.000 12/10/2007', default: 'yyyy')
    date.localize.should == '00:00:00.000 12/10/2007'
  end

  it "parses with time zone" do
    date = java::util::Date.parse('00:00:00.000 12/10/2007', time_zone: 'GMT')
    date.localize.should == '02:00:00.000 12/10/2007'
  end

  it "parses using input format first" do
    date = java::util::Date.parse('00:00:00.000 12.10.07', format: :default, locale: :fr)
    date.localize.should == '00:00:00.000 12/10/0007'
    date = java::util::Date.parse('00:00:00.000 12.10.07', locale: :fr)
    date.localize.should == '00:00:00.000 12/10/2007'
  end

  it "fails with parse exception on wrong format" do
    expect { java::util::Date.parse('12. Oct') }.to raise_error(java::text::ParseException)
  end
end
