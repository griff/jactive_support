require 'jactive_support/java_ext/iterable'
require File.expand_path('../shared/fixtures', __FILE__)

describe "java::lang::Iterable#shift" do
  it "removes and returns the first element" do
    a = Itr[5, 1, 1, 5, 4]
    a.shift.should == 5
    a.should == Itr[1, 1, 5, 4]
    a.shift.should == 1
    a.should == Itr[1, 5, 4]
    a.shift.should == 1
    a.should == Itr[5, 4]
    a.shift.should == 5
    a.should == Itr[4]
    a.shift.should == 4
    a.should == Itr[]
  end

  it "returns nil when the iterable is empty" do
    Itr[].shift.should == nil
  end

  it "properly handles recursive iterables" do
    empty = IterableSpecs.empty_recursive_iterable
    empty.shift.should == Itr[]
    empty.should == Itr[]

    iterable = IterableSpecs.recursive_iterable
    iterable.shift.should == 1
    iterable[0..2].should == Itr['two', 3.0, iterable]
  end

  ruby_version_is "" ... "1.9" do
    it "raises a TypeError on a frozen iterable" do
      lambda { IterableSpecs.frozen_iterable.shift }.should raise_error(TypeError)
    end
    it "raises a TypeError on an empty frozen iterable" do
      lambda { IterableSpecs.empty_frozen_iterable.shift }.should raise_error(TypeError)
    end
  end

  ruby_version_is "1.9" do
    it "raises a RuntimeError on a frozen iterable" do
      lambda { IterableSpecs.frozen_iterable.shift }.should raise_error(RuntimeError)
    end
    it "raises a RuntimeError on an empty frozen iterable" do
      lambda { IterableSpecs.empty_frozen_iterable.shift }.should raise_error(RuntimeError)
    end
  end

  ruby_version_is '' ... '1.8.7' do
    it "raises an ArgumentError if passed an argument" do
      lambda{ Itr[1, 2].shift(1) }.should raise_error(ArgumentError)
    end
  end

  describe "passed a number n as an argument" do
    ruby_version_is '1.8.7' do
      it "removes and returns an iterable with the first n element of the iterable" do
        a = Itr[1, 2, 3, 4, 5, 6]

        a.shift(0).should == []
        a.should == Itr[1, 2, 3, 4, 5, 6]

        a.shift(1).should == [1]
        a.should == Itr[2, 3, 4, 5, 6]

        a.shift(2).should == [2, 3]
        a.should == Itr[4, 5, 6]

        a.shift(3).should == [4, 5, 6]
        a.should == Itr[]
      end

      it "does not corrupt the iterable when shift without arguments is followed by shift with an argument" do
        a = Itr[1, 2, 3, 4, 5]

        a.shift.should == 1
        a.shift(3).should == [2, 3, 4]
        a.should == Itr[5]
      end

      it "returns a new empty iterable if there are no more elements" do
        a = Itr[]
        popped1 = a.shift(1)
        popped1.should == []
        a.should == Itr[]

        popped2 = a.shift(2)
        popped2.should == []
        a.should == Itr[]

        popped1.should_not equal(popped2)
      end

      it "returns whole elements if n exceeds size of the iterable" do
        a = Itr[1, 2, 3, 4, 5]
        a.shift(6).should == [1, 2, 3, 4, 5]
        a.should == Itr[]
      end

      it "does not return self even when it returns whole elements" do
        a = Itr[1, 2, 3, 4, 5]
        a.shift(5).should_not equal(a)

        a = Itr[1, 2, 3, 4, 5]
        a.shift(6).should_not equal(a)
      end

      it "raises an ArgumentError if n is negative" do
        lambda{ Itr[1, 2, 3].shift(-1) }.should raise_error(ArgumentError)
      end

      it "tries to convert n to an Integer using #to_int" do
        a = Itr[1, 2, 3, 4]
        a.shift(2.3).should == [1, 2]

        obj = mock('to_int')
        obj.should_receive(:to_int).and_return(2)
        a.should == Itr[3, 4]
        a.shift(obj).should == [3, 4]
        a.should == Itr[]
      end

      it "raises a TypeError when the passed n can be coerced to Integer" do
        lambda{ Itr[1, 2].shift("cat") }.should raise_error(TypeError)
        lambda{ Itr[1, 2].shift(nil) }.should raise_error(TypeError)
      end

      it "raises an ArgumentError if more arguments are passed" do
        lambda{ Itr[1, 2].shift(1, 2) }.should raise_error(ArgumentError)
      end

      it "returns ruby arrays" do
        Itr[1, 2, 3].shift(2).should be_kind_of(Array)
      end

      it "returns an untainted iterable even if the iterable is tainted" do
        ary = Itr[1, 2].taint
        ary.shift(2).tainted?.should be_false
        ary.shift(0).tainted?.should be_false
      end

      it "keeps taint status" do
        a = Itr[1, 2].taint
        a.shift(2)
        a.tainted?.should be_true
        a.shift(2)
        a.tainted?.should be_true
      end

      ruby_version_is '' ... '1.9' do
        it "raises a TypeError on a frozen iterable" do
          lambda { IterableSpecs.frozen_iterable.shift(2) }.should raise_error(TypeError)
          lambda { IterableSpecs.frozen_iterable.shift(0) }.should raise_error(TypeError)
        end
      end
    end
  end
end