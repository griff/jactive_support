require 'jactive_support/core_ext/string/locale'
require 'jactive_support/core_ext/string/inflections'
require 'jactive_support/core_ext/string/break'

class String #:nodoc:
  include JactiveSupport::CoreExtensions::String::Locale
  include JactiveSupport::CoreExtensions::String::Inflections
  include JactiveSupport::CoreExtensions::String::Break
  
  def flash_with_enum(other)
    if other.java_kind_of? ::Java::JavaLang::Enum
      other.name == self || other.name == camelize
    else
      flash_without_enum(other)
    end
  end
  alias :flash_without_enum :===
  alias :=== :flash_with_enum
end
