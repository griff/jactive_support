require 'jactive_support/core_ext/enum'

module JactiveSupport #:nodoc:
  module CoreExtensions #:nodoc:
    module Object #:nodoc:
      module Enum        
        def self.included(other_mod)
          other_mod.send :alias_method, :flash_without_enum, :===
          other_mod.send :alias_method, :===, :flash_with_enum

          other_mod.send :alias_method, :to_java_without_enum, :to_java
          other_mod.send :alias_method, :to_java, :to_java_with_enum
        end
      
        def flash_with_enum(other)
          if other.java_kind_of? ::Java::JavaLang::Enum
            other.name == self.to_s || other.name == self.to_s.camelize
          else
            flash_without_enum(other)
          end
        end
      
        def to_java_with_enum(other=nil)
          if other.superclass == ::Java::JavaLang::Enum
            other.find_value_of(self)
          else
            to_java_without_enum(other)
          end
        end
      end
    end
  end
end

class Symbol
  include ::JactiveSupport::CoreExtensions::Object::Enum
end

class String
  include ::JactiveSupport::CoreExtensions::Object::Enum
end