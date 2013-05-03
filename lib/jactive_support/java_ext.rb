Dir[File.dirname(__FILE__) + "/java_ext/*.rb"].sort.each do |path|
  filename = File.basename(path)
  require "jactive_support/java_ext/#{filename}"
end
