module JactiveSupport
  # Rescuable module adds support for easier exception handling.
  module Rescuable
    def self.included(base) # :nodoc:
      base.class_inheritable_accessor :java_rescue_handlers
      base.java_rescue_handlers = []

      base.extend(ClassMethods)
      base.rescue_from NativeException, :with=>:rescue_with_java_handler
    end
    
    module ClassMethods
        # Rescue exceptions raised in controller actions.
        #
        # <tt>rescue_from</tt> receives a series of exception classes or class
        # names, and a trailing <tt>:with</tt> option with the name of a method
        # or a Proc object to be called to handle them. Alternatively a block can
        # be given.
        #
        # Handlers that take one argument will be called with the exception, so
        # that the exception can be inspected when dealing with it.
        #
        # Handlers are inherited. They are searched from right to left, from
        # bottom to top, and up the hierarchy. The handler of the first class for
        # which <tt>exception.is_a?(klass)</tt> holds true is the one invoked, if
        # any.
        #
        #   class ApplicationController < ActionController::Base
        #     java_rescue_from User::NotAuthorized, :with => :deny_access # self defined exception
        #     java_rescue_from ActiveRecord::RecordInvalid, :with => :show_errors
        #
        #     java_rescue_from 'MyAppError::Base' do |exception|
        #       render :xml => exception, :status => 500
        #     end
        #
        #     protected
        #       def deny_access
        #         ...
        #       end
        #
        #       def show_errors(exception)
        #         exception.record.new_record? ? ...
        #       end
        #   end
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
