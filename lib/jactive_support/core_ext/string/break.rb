module JactiveSupport #:nodoc:
  module CoreExtensions #:nodoc:
    module String #:nodoc:
      module Break
        # Returns the java.util.Locale that maches this string
        def break
          self.to_s.gsub(/\n|\r\n?/, '<br>')
        end
      end
    end
  end
end