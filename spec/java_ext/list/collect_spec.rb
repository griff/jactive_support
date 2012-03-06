require 'jactive_support/java_ext/list'
require File.expand_path('../shared/fixtures', __FILE__)
require File.expand_path('../shared/collect', __FILE__)

describe "java::util::List#collect" do
  it_behaves_like(:list_collect, :collect)
end

describe "java::util::List#collect!" do
  it_behaves_like(:list_collect_b, :collect!)
end
