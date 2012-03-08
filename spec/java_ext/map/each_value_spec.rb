require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)
require File.expand_path('../shared/iteration', __FILE__)

describe "Hash#each_value" do
=begin self
  it "returns self" do
    h = new_hash(:a => -5, :b => -3, :c => -2, :d => -1, :e => -1)
    h.each_value { |v|  }.should equal(h)
  end
=end
  
  it "calls block once for each key, passing value" do
    r = []
    h = new_hash(:a => -5, :b => -3, :c => -2, :d => -1, :e => -1)
    h.each_value { |v| r << v }
    r.sort.should == [-5, -3, -2, -1, -1]
  end

  it "processes values in the same order as values()" do
    values = []
    h = new_hash(:a => -5, :b => -3, :c => -2, :d => -1, :e => -1)
    h.each_value { |v| values << v }
    values.should == h.values.to_a
  end

  it_behaves_like(:hash_iteration_no_block, :each_value)
end