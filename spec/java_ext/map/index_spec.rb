require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)
require File.expand_path('../shared/index', __FILE__)

describe "Hash#index" do
  it_behaves_like :hash_index, :index
end
