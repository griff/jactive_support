require 'jactive_support/java_ext/list'
require File.expand_path('../shared/fixtures', __FILE__)

describe "java::util::List#clear" do
  it "removes all elements" do
    a = List[1, 2, 3, 4]
    a.clear.should equal(a)
    a.should == List[]
  end

  it "returns self" do
    a = List[1]
    oid = a.object_id
    a.clear.object_id.should == oid
  end

  it "leaves the List empty" do
    a = List[1]
    a.clear
    a.empty?.should == true
  end

  it "keeps tainted status" do
    a = List[1]
    a.taint
    a.tainted?.should be_true
    a.clear
    a.tainted?.should be_true
  end

  it "does not accept any arguments" do
    lambda { List[1].clear(true) }.should raise_error(ArgumentError)
  end

  ruby_version_is '1.9' do
    it "keeps untrusted status" do
      a = List[1]
      a.untrust
      a.untrusted?.should be_true
      a.clear
      a.untrusted?.should be_true
    end
  end

  ruby_version_is '' ... '1.9' do
    it "raises a TypeError on a frozen array" do
      lambda { ListSpecs.frozen_list.clear }.should raise_error(TypeError)
    end
  end

  ruby_version_is '1.9' do
    it "raises a RuntimeError on a frozen array" do
      lambda { ListSpecs.frozen_list.clear }.should raise_error(RuntimeError)
    end
  end
end
