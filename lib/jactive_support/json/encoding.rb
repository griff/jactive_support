Dir["#{File.dirname(__FILE__)}/encoders/**/*.rb"].each do |file|
  basename = File.basename(file, '.rb')
  require "jactive_support/json/encoders/#{basename}"
end
