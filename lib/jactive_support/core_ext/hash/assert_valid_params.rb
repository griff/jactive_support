module JactiveSupport
  class InvalidParameter < ArgumentError
  end
end

class Hash
  # Validate all keys in a hash match *valid keys, raising ArgumentError on a mismatch.
  # Note that keys are NOT treated indifferently, meaning if you use strings for keys but assert symbols
  # as keys, this will fail.
  #
  # ==== Examples
  #   { :name => "Rob", :years => "28" }.assert_valid_keys(:name, :age) # => raises "ArgumentError: Unknown key(s): years"
  #   { :name => "Rob", :age => "28" }.assert_valid_keys("name", "age") # => raises "ArgumentError: Unknown key(s): name, age"
  #   { :name => "Rob", :age => "28" }.assert_valid_keys(:name, :age) # => passes, raises nothing
  def assert_valid_params(*valid_keys)
    unknown_keys = keys.map{|key| key.to_sym} - [valid_keys].flatten
    raise(::JactiveSupport::InvalidParameter, "Unknown key(s): #{unknown_keys.join(", ")}") unless unknown_keys.empty?
  end
end