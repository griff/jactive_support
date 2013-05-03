require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)
require File.expand_path('../shared/replace', __FILE__)

describe "Hash#initialize_copy" do
=begin private
  it "is private" do
    hash_class.should have_private_instance_method("initialize_copy")
  end
=end

  it_behaves_like(:hash_replace, :initialize_copy)
end
