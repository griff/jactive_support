require 'jactive_support/java_ext/iterable'
require File.expand_path('../shared/fixtures', __FILE__)
require File.expand_path('../shared/enumeratorize', __FILE__)

describe "java::lang::Iterable#delete_if" do
  before do
    @a = Itr[ "a", "b", "c" ]
  end

  it "removes each element for which block returns true" do
    @a = Itr[ "a", "b", "c" ]
    @a.delete_if { |x| x >= "b" }
    @a.should == Itr["a"]
  end

  it "returns self" do
    @a.delete_if{ true }.equal?(@a).should be_true
  end

  it_behaves_like :enumeratorize, :delete_if

  it "returns self when called on an Iterable emptied with #shift" do
    iterable = Itr[1]
    iterable.shift
    iterable.delete_if { |x| true }.should equal(iterable)
  end

  ruby_version_is '1.8.7' do
    it "returns an Enumerator if no block given, and the enumerator can modify the original iterable" do
      enum = @a.delete_if
      enum.should be_an_instance_of(enumerator_class)
      @a.should_not be_empty
      enum.each { true }
      @a.should be_empty
    end
  end

  ruby_version_is '' ... '1.9' do
    it "raises a TypeError on a frozen iterable" do
      lambda { IterableSpecs.frozen_iterable.delete_if {} }.should raise_error(TypeError)
    end
    it "raises a TypeError on an empty frozen iterable" do
      lambda { IterableSpecs.empty_frozen_iterable.delete_if {} }.should raise_error(TypeError)
    end
  end

  ruby_version_is '1.9' do
    it "raises a RuntimeError on a frozen iterable" do
      lambda { IterableSpecs.frozen_iterable.delete_if {} }.should raise_error(RuntimeError)
    end
    it "raises a RuntimeError on an empty frozen iterable" do
      lambda { IterableSpecs.empty_frozen_iterable.delete_if {} }.should raise_error(RuntimeError)
    end
  end

  it "keeps tainted status" do
    @a.taint
    @a.tainted?.should be_true
    @a.delete_if{ true }
    @a.tainted?.should be_true
  end

  ruby_version_is '1.9' do
    it "keeps untrusted status" do
      @a.untrust
      @a.untrusted?.should be_true
      @a.delete_if{ true }
      @a.untrusted?.should be_true
    end
  end
end