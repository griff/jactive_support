module JactiveSupport #:nodoc:
  module CoreExtensions #:nodoc:
    module SqlDate #:nodoc:
      # Converting dates to formatted strings, times, and datetimes.
      module Conversions
        DATE_FORMATS = {
          :db           => "yyyy-MM-dd",
          :number       => "YYYMMdd",
          :full         => lambda { |time, locale| time.class.date_instance(:full, locale).format(time) },
          :long         => lambda { |time, locale| time.class.date_instance(:long, locale).format(time) },
          :medium       => lambda { |time, locale| time.class.date_instance(:medium, locale).format(time) },
          :short        => lambda { |time, locale| time.class.date_instance(:short, locale).format(time) },
          :default      => lambda { |time, locale| time.class.date_instance(:default, locale).format(time) },
          :long_ordinal => lambda { |time| time.format_date("%B #{time.day.ordinalize}, %Y %H:%M") },
          :rfc822       => lambda { |time| time.format_date("%a, %d %b %Y %H:%M:%S #{time.formatted_offset(false)}") },
          :httpdate     => lambda { |time| time.format_date("EEE, dd MMM yyyy HH:mm:ss z", "GMT") }
        }
        
        # Converts a java.sql.Date object to a ruby Date.
        #
        #   my_time = java.sql.Date.new  # => Mon, 12 Nov 2007
        #   my_time.to_date     # => Mon, 12 Nov 2007
#        def to_date
#          ::Date.new(getYear, getMonth, getDay)
#        end
      end
    end
  end
end