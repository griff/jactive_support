require 'jactive_support/java_ext/list'
require File.expand_path('../shared/fixtures', __FILE__)
require File.expand_path('../shared/collect', __FILE__)

describe "java::util::List#map" do
  it_behaves_like(:list_collect, :map)
end

describe "java::util::List#map!" do
  it_behaves_like(:list_collect_b, :map!)
end
