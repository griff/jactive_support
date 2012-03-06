require 'jactive_support/core_ext/module'

class Base
  def self.inherited(other)
    other.instance_variable_set('@thename', other.name || '')
  end
end

Test2 = Class.new(Base)

describe Module, 'define_class' do
  it "normal dynamic class does not have access to name in inherited" do
    Test2.instance_variable_get('@thename').should eq('')
  end
  
  it "should have access to name even in inherited" do
    Object.define_class('Test', Base).instance_variable_get('@thename').should eq('Test')
  end
end