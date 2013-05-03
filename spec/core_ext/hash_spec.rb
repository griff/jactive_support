require 'jactive_support/core_ext/hash'

describe Hash do
  describe "assert_valid_params" do
    it "should not raise an error when assert_valid_params is called with correct parameters" do
      { :failure => "stuff", :funny => "business" }.assert_valid_params([ :failure, :funny ])
      { :failure => "stuff", :funny => "business" }.assert_valid_params(:failure, :funny)
    end

    it "should raise an error when assert_valid_params is called with incorrect parameters" do
      expect{ 
        { :failore => "stuff", :funny => "business" }.assert_valid_params([ :failure, :funny ])
      }.to raise_error(JactiveSupport::InvalidParameter, "Unknown key(s): failore")
  
      expect{ 
        { :failore => "stuff", :funny => "business" }.assert_valid_params(:failure, :funny) 
      }.to raise_error(JactiveSupport::InvalidParameter, "Unknown key(s): failore")
    end
  end
  
  describe "supports with_keys_values" do
    it "should make a new Hash with arguments as keys and values" do
      Hash.with_keys_values([:one, :two], [1, 2]).should eq(:one=>1, :two=>2)
    end
    
    it "should support empty arrays" do
      Hash.with_keys_values([], []).should eq({})
    end
    
    it "raises ArgumentError when keys and values don't have same size" do
      expect { Hash.with_keys_values([:one, :two], [1]) }.to raise_error(ArgumentError, "Unmatching sizes 2 != 1")
    end
  end
end