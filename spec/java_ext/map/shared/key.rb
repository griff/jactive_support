shared_examples_for :hash_key_p do |method|
  before { @method = method }

  it "returns true if argument is a key" do
    h = new_hash(:a => 1, :b => 2, :c => 3, 4 => 0)
    h.send(@method, :a).should == true
    h.send(@method, :b).should == true
    h.send(@method, 'b').should == false
    h.send(@method, 2).should == false
    h.send(@method, 4).should == true
    h.send(@method, 4.0).should == false
  end

=begin nil
  it "returns true if the key's matching value was nil" do
    new_hash(:xyz => nil).send(@method, :xyz).should == true
  end
=end

  it "returns true if the key's matching value was false" do
    new_hash(:xyz => false).send(@method, :xyz).should == true
  end

=begin nil
  it "returns true if the key is nil" do
    new_hash(nil => 'b').send(@method, nil).should == true
    new_hash(nil => nil).send(@method, nil).should == true
  end
=end

=begin hashCode equals
  it "compares keys with the same #hashCode value via #equals" do
    x = mock('x')
    x.stub!(:hashCode).and_return(42)

    y = mock('y')
    y.stub!(:hashCode).and_return(42)
    y.should_receive(:equals).and_return(false)

    new_hash(x => nil).send(@method, y).should == false
  end
=end
end
