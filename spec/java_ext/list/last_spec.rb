require 'jactive_support/java_ext/list'
require File.expand_path('../shared/fixtures', __FILE__)

describe "java::util::List#last" do
  it "returns the last element" do
    List[1, 1, 1, 1, 2].last.should == 2
  end

  it "returns nil if self is empty" do
    List[].last.should == nil
  end

  it "returns the last count elements if given a count" do
    List[1, 2, 3, 4, 5, 9].last(3).should == [4, 5, 9]
  end

  it "returns an empty list when passed a count on an empty list" do
    List[].last(0).should == []
    List[].last(1).should == []
  end

  it "returns an empty list when count == 0" do
    List[1, 2, 3, 4, 5].last(0).should == []
  end

  it "returns an list containing the last element when passed count == 1" do
    List[1, 2, 3, 4, 5].last(1).should == [5]
  end

  it "raises an ArgumentError when count is negative" do
    lambda { List[1, 2].last(-1) }.should raise_error(ArgumentError)
  end

  it "returns the entire list when count > length" do
    List[1, 2, 3, 4, 5, 9].last(10).should == [1, 2, 3, 4, 5, 9]
  end

  it "returns an list which is independent to the original when passed count" do
    ary = List[1, 2, 3, 4, 5]
    ary.last(0).replace([1,2])
    ary.should == List[1, 2, 3, 4, 5]
    ary.last(1).replace([1,2])
    ary.should == List[1, 2, 3, 4, 5]
    ary.last(6).replace([1,2])
    ary.should == List[1, 2, 3, 4, 5]
  end

  it "properly handles recursive lists" do
    empty = ListSpecs.empty_recursive_list
    empty.last.should equal(empty)

    list = ListSpecs.recursive_list
    list.last.should equal(list)
  end

  it "tries to convert the passed argument to an Integer usinig #to_int" do
    obj = mock('to_int')
    obj.should_receive(:to_int).and_return(2)
    List[1, 2, 3, 4, 5].last(obj).should == [4, 5]
  end

  it "raises a TypeError if the passed argument is not numeric" do
    lambda { List[1,2].last(nil) }.should raise_error(TypeError)
    lambda { List[1,2].last("a") }.should raise_error(TypeError)

    obj = mock("nonnumeric")
    lambda { List[1,2].last(obj) }.should raise_error(TypeError)
  end

  it "does not return subclass instance on List subclasses" do
    List[].last(0).should be_kind_of(Array)
    List[].last(2).should be_kind_of(Array)
    List[1, 2, 3].last(0).should be_kind_of(Array)
    List[1, 2, 3].last(1).should be_kind_of(Array)
    List[1, 2, 3].last(2).should be_kind_of(Array)
  end

  it "is not destructive" do
    a = List[1, 2, 3]
    a.last
    a.should == List[1, 2, 3]
    a.last(2)
    a.should == List[1, 2, 3]
    a.last(3)
    a.should == List[1, 2, 3]
  end
end