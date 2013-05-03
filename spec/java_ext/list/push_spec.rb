require 'jactive_support/java_ext/list'
require File.expand_path('../shared/fixtures', __FILE__)

describe "java::util::List#push" do
  it "appends the arguments to the list" do
    a = List[ "a", "b", "c" ]
    a.push("d", "e", "f").should equal(a)
    a.push().should == List["a", "b", "c", "d", "e", "f"]
    a.push(5)
    a.should == List["a", "b", "c", "d", "e", "f", 5]
  end

  it "isn't confused by previous shift" do
    a = List[ "a", "b", "c" ]
    a.shift
    a.push("foo")
    a.should == List["b", "c", "foo"]
  end

  it "properly handles recursive lists" do
    empty = ListSpecs.empty_recursive_list
    empty.push(:last).should == List[empty, :last]

    list = ListSpecs.recursive_list
    list.push(:last).should == List[1, 'two', 3.0, list, list, list, list, list, :last]
  end

  ruby_version_is "" ... "1.9" do
    it "raises a TypeError on a frozen list if modification takes place" do
      lambda { ListSpecs.frozen_list.push(1) }.should raise_error(TypeError)
    end

    it "does not raise on a frozen list if no modification is made" do
      ListSpecs.frozen_list.push.should == List[1, 2, 3]
    end
  end

  ruby_version_is "1.9" do
    it "raises a RuntimeError on a frozen list" do
      lambda { ListSpecs.frozen_list.push(1) }.should raise_error(RuntimeError)
      lambda { ListSpecs.frozen_list.push }.should raise_error(RuntimeError)
    end
  end
end