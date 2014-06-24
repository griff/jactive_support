require 'jactive_support/java_ext/date/conversions'

describe "java::util::Date#strformat" do
  it "formats year" do
    date = java::util::Date.new(1192140000000)
    date.strformat('yyyy').should == '2007'
  end

  it "formats month" do
    date = java::util::Date.new(1192140000000)
    date.strformat('MM').should == '10'
  end

  it "formats abbreviated month" do
    date = java::util::Date.new(1192140000000)
    date.strformat('MMM', locale: 'en').should == 'Oct'
  end

  it "formats danish abbreviated month" do
    date = java::util::Date.new(1192140000000)
    date.strformat('MMM', locale: 'da_DK'.to_locale).should == 'okt'
  end

  it "formats fulle month" do
    date = java::util::Date.new(1192140000000)
    date.strformat('MMMM', locale: 'en').should == 'October'
  end

  it "formats danish full month" do
    date = java::util::Date.new(1192140000000)
    date.strformat('MMMM', locale: 'da_DK'.to_locale).should == 'oktober'
  end

  it "formats rfc822 date" do
    date = java::util::Date.new(1192140000000)
    date.strformat('EEE, dd MMM yyyy HH:mm:ss Z', locale: 'en', timezone: 'CET')
      .should == 'Fri, 12 Oct 2007 00:00:00 +0200'
  end
end