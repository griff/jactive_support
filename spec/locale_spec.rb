require 'jactive_support/core_ext/locale'

describe Locale do
  before {java::util::Locale.setDefault(java::util::Locale.new('en'))}
  subject {Locale.new('en', 'UK')}

  it { Locale.should be(java.util.Locale) }

  it "should have a current locale" do
    Locale.current_locale.should be(Locale.getDefault)
  end
  
  it "has a human name" do
    subject.human_name.should eq('English (UK)')
  end

  it "supports inspect" do
    subject.inspect.should eq('Locale[English (UK)]')
  end
  
  it "supports to_s" do
    subject.to_s.should eq('en_UK')
  end

  it "supports to_str" do
    subject.to_str.should eq('en_UK')
  end

  it "supports to_sym" do
    subject.to_sym.should eq(:en_UK)
  end
  
  it "can convert string to locale" do
    "en".to_locale.should eq(Locale.new('en'))
    "en_UK".to_locale.should eq(Locale.new('en', 'UK'))
    "en-UK".to_locale.should eq(Locale.new('en', 'UK'))
    "en_UK_Ireland".to_locale.should eq(Locale.new('en', 'UK', 'Ireland'))
    "en-UK-Ireland".to_locale.should eq(Locale.new('en', 'UK', 'Ireland'))
    "en_UK-Ireland".to_locale.should eq(Locale.new('en', 'UK', 'Ireland'))
    "en-UK_Ireland".to_locale.should eq(Locale.new('en', 'UK', 'Ireland'))
  end
  
  it "can convert symbol to locale" do
    :en.to_locale.should eq(Locale.new('en'))
    :en_UK.to_locale.should eq(Locale.new('en', 'UK'))
    :'en-UK'.to_locale.should eq(Locale.new('en', 'UK'))
    :en_UK_Ireland.to_locale.should eq(Locale.new('en', 'UK', 'Ireland'))
    :'en-UK-Ireland'.to_locale.should eq(Locale.new('en', 'UK', 'Ireland'))
    :'en_UK-Ireland'.to_locale.should eq(Locale.new('en', 'UK', 'Ireland'))
    :'en-UK_Ireland'.to_locale.should eq(Locale.new('en', 'UK', 'Ireland'))
  end

  it "converting nil to a locale is the same as the default locale" do
    nil.to_locale.should be(Locale.current_locale)
  end
  
  it "can set current locale" do
    Locale.current_locale = Locale.new('en')
    Locale.current_locale.should eq(:en.to_locale)
  end
  
  it "can set current locale to a string" do
    Locale.current_locale = 'en'
    Locale.current_locale.should eq(:en.to_locale)
  end
  
  it "can set current locale to a symbol" do
    Locale.current_locale = :en
    Locale.current_locale.should eq(:en.to_locale)
  end
  
  it "can set current locale to nil and it has no effect" do
    old = Locale.current_locale
    Locale.current_locale = nil
    Locale.current_locale.should eq(old)
  end
end