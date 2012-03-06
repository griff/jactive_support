require 'jactive_support/java_ext/iterable'
require File.expand_path('../shared/fixtures', __FILE__)
require File.expand_path('../shared/enumeratorize', __FILE__)

describe "java::lang::Iterable#reject!" do
  it "removes elements for which block is true" do
    a = Itr[3, 4, 5, 6, 7, 8, 9, 10, 11]
    a.reject! { |i| i % 2 == 0 }.should equal(a)
    a.should == Itr[3, 5, 7, 9, 11]
    a.reject! { |i| i > 8 }
    a.should == Itr[3, 5, 7]
    a.reject! { |i| i < 4 }
    a.should == Itr[5, 7]
    a.reject! { |i| i == 5 }
    a.should == Itr[7]
    a.reject! { true }
    a.should == Itr[]
    a.reject! { true }
    a.should == Itr[]
  end

  it "properly handles recursive iterables" do
    empty = IterableSpecs.empty_recursive_iterable
    empty_dup = empty.dup
    empty.reject! { false }.should == nil
    empty.should == empty_dup

    empty = IterableSpecs.empty_recursive_iterable
    empty.reject! { true }.should == Itr[]
    empty.should == Itr[]

    iterable = IterableSpecs.recursive_iterable
    iterable_dup = iterable.dup
    iterable.reject! { false }.should == nil
    iterable.should == iterable_dup

    iterable = IterableSpecs.recursive_iterable
    iterable.reject! { true }.should == Itr[]
    iterable.should == Itr[]
  end

  it "returns nil when called on an Iterable emptied with #shift" do
    iterable = Itr[1]
    iterable.shift
    iterable.reject! { |x| true }.should == nil
  end

  it "returns nil if no changes are made" do
    a = Itr[1, 2, 3]

    a.reject! { |i| i < 0 }.should == nil

    a.reject! { true }
    a.reject! { true }.should == nil
  end

  ruby_version_is "" ... "1.9" do
    it "raises a TypeError on a frozen iterable" do
      lambda { IterableSpecs.frozen_iterable.reject! {} }.should raise_error(TypeError)
    end
    it "raises a TypeError on an empty frozen iterable" do
      lambda { IterableSpecs.empty_frozen_iterable.reject! {} }.should raise_error(TypeError)
    end
  end

  ruby_version_is "1.9" do
    it "raises a RuntimeError on a frozen iterable" do
      lambda { IterableSpecs.frozen_iterable.reject! {} }.should raise_error(RuntimeError)
    end
    it "raises a RuntimeError on an empty frozen iterable" do
      lambda { IterableSpecs.empty_frozen_iterable.reject! {} }.should raise_error(RuntimeError)
    end
  end

  it_behaves_like :enumeratorize, :reject!
end