require File.expand_path('../../../spec_helper', __FILE__)
require File.expand_path('../fixtures/classes', __FILE__)
require File.expand_path('../shared/to_s', __FILE__)

describe "Hash#inspect" do
=begin stack level to deep
  it_behaves_like :to_s, :inspect
=end
end
