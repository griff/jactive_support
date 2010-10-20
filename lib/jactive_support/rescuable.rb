module ActiveSupport
  # Rescuable module adds support for easier exception handling.
  module Rescuable
    
    module ClassMethods
      def java_rescue_from(*klasses, &block)
        options = klasses.extract_options!

        unless options.has_key?(:with)
          if block_given?
            options[:with] = block
          else
            raise ArgumentError, "Need a handler. Supply an options hash that has a :with key as the last argument."
          end
        end

        klasses.each do |klass|
          key = if klass.is_a?(Class) && klass <= java.lang.Exception
            klass.name
          elsif klass.is_a?(String)
            klass
          else
            raise ArgumentError, "#{klass} is neither an java.lang.Exception nor a String"
          end

          # put the new handler at the end because the list is read in reverse
          java_rescue_handlers << [key, options[:with]]
        end
      end
    end

    def rescue_with_java_handler(exception)
    end

    def java_handler_for_rescue(exception)
    end
  end
end
