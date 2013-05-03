require 'jactive_support/java_ext/iterable'
require File.expand_path('../shared/fixtures', __FILE__)

describe "java::lang::Iterable#empty?" do
  it "returns true if the iterable has no elements" do
    Itr[].empty?.should == true
    Itr[1].empty?.should == false
    Itr[1, 2].empty?.should == false
  end
end
