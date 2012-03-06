shared_examples_for :hash_length do |method|
  before { @method = method }

  it "returns the number of entries" do
    new_hash(:a => 1, :b => 'c').send(@method).should == 2
    new_hash(:a => 1, :b => 2, :a => 2).send(@method).should == 2
    new_hash(:a => 1, :b => 1, :c => 1).send(@method).should == 3
    new_hash().send(@method).should == 0
    new_hash(5).send(@method).should == 0
    new_hash { 5 }.send(@method).should == 0
  end
end
