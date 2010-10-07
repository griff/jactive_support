module JactiveSupport #:nodoc:
  module CoreExtensions #:nodoc:
    module String #:nodoc:
      module Inflections
        # Removes the module part from the expression in the string.
        #
        # Examples:
        #   "ActiveRecord::CoreExtensions::String::Inflections".demodulize # => "Inflections"
        #   "Inflections".demodulize                                       # => "Inflections"
        def names
          self.to_s.split(/::/)
        end
        
        def parent_module
          self.to_s.sub(/::\w+$/, '')
        end
      end
    end
  end
end