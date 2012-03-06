require 'jactive_support/core_ext/ordering'

describe "ordering" do
  it "has an order" do
    (nil <=> nil).should be(0)
    (nil <=> 1).should be(-1)
    (true <=> true).should be(0)
    (true <=> 1).should be(-1)
    (false <=> false).should be(0)
    (false <=> 1).should be(1)
  end
end