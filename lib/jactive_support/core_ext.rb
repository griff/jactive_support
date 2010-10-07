Dir[File.dirname(__FILE__) + "/core_ext/*.rb"].sort.each do |path|
  filename = File.basename(path)
  require "jactive_support/core_ext/#{filename}"
end
