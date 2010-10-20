require 'jactive_support/core_ext/string/locale'
require 'jactive_support/core_ext/string/inflections'
require 'jactive_support/core_ext/string/break'

class String #:nodoc:
  include JactiveSupport::CoreExtensions::String::Inflections
end
