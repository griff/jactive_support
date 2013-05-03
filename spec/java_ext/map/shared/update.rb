shared_examples_for :hash_update do |method|
  before { @method = method }

=begin self
  it "returns self" do
    h = new_hash(:_1 => 'a', :_2 => '3')
    h.send(@method, :_1 => '9', :_9 => 2).should equal(h)
  end
=end

  it "adds the entries from other, overwriting duplicate keys" do
    h = new_hash(:_1 => 'a', :_2 => '3')
    h.send(@method, :_1 => '9', :_9 => 2)
    h.should == new_hash(:_1 => "9", :_2 => "3", :_9 => 2)
  end

=begin self
  it "returns self with block" do
    h1 = new_hash(:a => 2, :b => -1)
    h2 = new_hash(:a => -2, :c => 1)
    h1.send(@method, h2) { |k,x,y| 3.14 }.should equal(h1)
  end
=end

=begin nil
  it "sets any duplicate key to the value of block if passed a block" do
    h1 = new_hash(:a => 2, :b => -1)
    h2 = new_hash(:a => -2, :c => 1)
    h1.send(@method, h2) { |k,x,y| 3.14 }
    h1.should == new_hash(:c => 1, :b => -1, :a => 3.14)

    h1.send(@method, h1) { nil }
    h1.should == new_hash(:a => nil, :b => nil, :c => nil)
  end
=end

  it "tries to convert the passed argument to a hash using #to_hash" do
    obj = mock('{1=>2}')
    obj.should_receive(:to_hash).and_return(new_hash(1 => 2).to_hash)
    new_hash(3 => 4).send(@method, obj).should == new_hash(1 => 2, 3 => 4)
  end

  it "does not call to_hash on hash subclasses" do
    new_hash(3 => 4).send(@method, ToHashHash[1 => 2]).should == new_hash(1 => 2, 3 => 4)
  end

=begin nil
  it "processes entries with same order as merge()" do
    h = new_hash(1 => 2, 3 => 4, 5 => 6, "x" => nil, nil => 5, [] => [])
    merge_bang_pairs = []
    merge_pairs = []
    h.merge(h) { |*arg| merge_pairs << arg }
    h.send(@method, h) { |*arg| merge_bang_pairs << arg }
    merge_bang_pairs.should == merge_pairs
  end
=end

=begin frozen
  ruby_version_is ""..."1.9" do
    it "raises a TypeError if called on a non-empty, frozen instance" do
      lambda { HashSpecs.frozen_hash.send(@method, 1 => 2) }.should raise_error(TypeError)
    end

    it "does not raise an exception on a frozen instance that would not be modified" do
      hash = HashSpecs.frozen_hash.send(@method, HashSpecs.empty_frozen_hash)
      hash.should == HashSpecs.frozen_hash
    end
  end

  ruby_version_is "1.9" do
    it "raises a RuntimeError on a frozen instance that is modified" do
      lambda do
        HashSpecs.frozen_hash.send(@method, 1 => 2)
      end.should raise_error(RuntimeError)
    end

    it "checks frozen status before coercing an object with #to_hash" do
      obj = mock("to_hash frozen")
      # This is necessary because mock cleanup code cannot run on the frozen
      # object.
      def obj.to_hash() raise Exception, "should not receive #to_hash" end
      obj.freeze

      lambda { HashSpecs.frozen_hash.send(@method, obj) }.should raise_error(RuntimeError)
    end

    # see redmine #1571
    it "raises a RuntimeError on a frozen instance that would not be modified" do
      lambda do
        HashSpecs.frozen_hash.send(@method, HashSpecs.empty_frozen_hash)
      end.should raise_error(RuntimeError)
    end
  end
=end
end
