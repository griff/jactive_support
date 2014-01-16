require 'active_support/rescuable'
require 'jactive_support/java_blamable'

module ActiveSupport
  module Rescuable
    module ClassMethods
      def rescue_from(*klasses, &block)
        options = klasses.extract_options!

        unless options.has_key?(:with)
          if block_given?
            options[:with] = block
          else
            raise ArgumentError, "Need a handler. Supply an options hash that has a :with key as the last argument."
          end
        end

        klasses.each do |klass|
          key = if klass.is_a?(Class) && ( klass <= Exception || klass <= ::Java::JavaLang::Exception )
            klass.name
          elsif klass.is_a?(String)
            klass
          else
            raise ArgumentError, "#{klass} is neither an Exception nor a String"
          end

          # put the new handler at the end because the list is read in reverse
          self.rescue_handlers += [[key, options[:with]]]
        end
      end
    end

    def handler_for_rescue(exception)
      # We go from right to left because pairs are pushed onto rescue_handlers
      # as rescue_from declarations are found.
      _, rescuer = self.class.rescue_handlers.reverse.detect do |klass_name, handler|
        # The purpose of allowing strings in rescue_from is to support the
        # declaration of handler associations for exception classes whose
        # definition is yet unknown.
        #
        # Since this loop needs the constants it would be inconsistent to
        # assume they should exist at this point. An early raised exception
        # could trigger some other handler and the array could include
        # precisely a string whose corresponding constant has not yet been
        # seen. This is why we are tolerant to unknown constants.
        #
        # Note that this tolerance only matters if the exception was given as
        # a string, otherwise a NameError will be raised by the interpreter
        # itself when rescue_from CONSTANT is executed.
        klass = self.class.const_get(klass_name) rescue nil
        klass ||= klass_name.constantize rescue nil
        exception.is_a?(klass) || (exception.is_a?(NativeException) && exception.cause.is_a?(klass)) if klass
      end

      case rescuer
      when Symbol
        method(rescuer)
      when Proc
        rescuer.bind(self)
      end
    end
  end
end
