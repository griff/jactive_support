require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)
require File.expand_path('../shared/iteration', __FILE__)

describe "Hash#delete_if" do
  it "yields two arguments: key and value" do
    all_args = []
    new_hash(1 => 2, 3 => 4).delete_if { |*args| all_args << args }
    all_args.sort.should == [[1, 2], [3, 4]]
  end

=begin self
  it "returns self" do
    h = new_hash(:a => 1, :b => 2, :c => 3, :d => 4)
    h.delete_if { |k,v| v % 2 == 1 }.should equal(h)
  end
=end

  it "removes every entry for which block is true" do
    h = new_hash(:a => 1, :b => 2, :c => 3, :d => 4)
    h.delete_if { |k,v| v % 2 == 1 }
    h.should == new_hash(:b => 2, :d => 4)
  end

  it "processes entries with the same order as each()" do
    h = new_hash(:a => 1, :b => 2, :c => 3, :d => 4)

    each_pairs = []
    delete_pairs = []

    h.each_pair { |k,v| each_pairs << [k, v] }
    h.delete_if { |k,v| delete_pairs << [k,v] }

    each_pairs.should == delete_pairs
  end

=begin frozen
  ruby_version_is "" ... "1.9" do
    it "raises an TypeError if called on a frozen instance" do
      lambda { HashSpecs.frozen_hash.delete_if { false } }.should raise_error(TypeError)
      lambda { HashSpecs.empty_frozen_hash.delete_if { true } }.should raise_error(TypeError)
    end
  end

  ruby_version_is "1.9" do
    it "raises an RuntimeError if called on a frozen instance" do
      lambda { HashSpecs.frozen_hash.delete_if { false } }.should raise_error(RuntimeError)
      lambda { HashSpecs.empty_frozen_hash.delete_if { true } }.should raise_error(RuntimeError)
    end
  end
=end

  it_behaves_like(:hash_iteration_no_block, :delete_if)
end
