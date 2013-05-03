require 'java'
require 'active_support'
require 'jactive_support/constantize'

class InflectorTest
  def call_constantize(name)
    ActiveSupport::Inflector.constantize(name)
  end
end
module Ace
  module Base
    class Case
    end
  end
end

describe "constantize with jruby" do

  it "should find named ruby constants" do
    ActiveSupport::Inflector.constantize("Ace::Base::Case").should be(Ace::Base::Case)
    ActiveSupport::Inflector.constantize("::Ace::Base::Case").should be(Ace::Base::Case)
    ActiveSupport::Inflector.constantize("::InflectorTest").should be(InflectorTest)
  end
  
  it "raises a NameError on invalid ruby constants" do
    expect { ActiveSupport::Inflector.constantize("UnknownClass") }.to raise_error(NameError, 'uninitialized constant UnknownClass')
    expect { ActiveSupport::Inflector.constantize("An invalid string") }.to raise_error(NameError, 'wrong constant name An invalid string')
    expect { ActiveSupport::Inflector.constantize("InvalidClass\n") }.to raise_error(NameError, "wrong constant name InvalidClass\n")
  end

  it "should do lexical lookup" do
    expect{ puts InflectorTest.new.call_constantize("::Ace::Base::InflectorTest").inspect }.to raise_error(NameError, 'uninitialized constant Ace::Base::InflectorTest')
  end
  
  it "should find a java class" do
    ActiveSupport::Inflector.constantize("Java::JavaLang::Thread").should be(java.lang.Thread);
  end
  
  it "should be able to lookup the canonical name of a java class" do
    ActiveSupport::Inflector.constantize(java.lang.Thread.name).should be(java.lang.Thread);
  end

  it "should raise a NameError when trying to lookup an unknown java class" do
    expect{ ActiveSupport::Inflector.constantize("Java::ComMuh::Miav") }.to raise_error(NameError, 'cannot load Java class com.muh.Miav')
  end
  
#=begin comment
  #Java packages currently don't have a should method with the normal setup
  it "should find a java package" do
    ActiveSupport::Inflector.constantize("Java::JavaLang").should be(java.lang);
  end

  it "should find an unknown java package" do
    ActiveSupport::Inflector.constantize("Java::ComMuh").should be(nil)
  end
#=end
end
