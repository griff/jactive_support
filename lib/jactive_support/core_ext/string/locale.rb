module JactiveSupport #:nodoc:
  module CoreExtensions #:nodoc:
    module String #:nodoc:
      module Locale
        # Returns the java.util.Locale that maches this string
        def to_locale
          Java::JavaUtil::Locale.new(self)
        end
      end
    end
  end
end