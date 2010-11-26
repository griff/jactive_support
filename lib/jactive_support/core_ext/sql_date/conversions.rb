module JactiveSupport #:nodoc:
  module CoreExtensions #:nodoc:
    module SqlDate #:nodoc:
      # Converting dates to formatted strings, times, and datetimes.
      module Conversions
        DATE_FORMATS = {
          :db           => "yyyy-MM-dd",
          :i18n         => lambda { |clazz, locale| 
                              format = I18n.translate(:"formats.date", :default=>'')
                              !format.blank? ? clazz.pattern_formatter(format) : clazz.date_instance(:default, locale)
                            },
          :number       => "YYYMMdd",
          :full         => lambda { |clazz, locale| clazz.date_instance(:full, locale) },
          :long         => lambda { |clazz, locale| clazz.date_instance(:long, locale) },
          :medium       => lambda { |clazz, locale| clazz.date_instance(:medium, locale) },
          :short        => lambda { |clazz, locale| clazz.date_instance(:short, locale) },
          :default      => lambda { |clazz, locale| clazz.date_instance(:default, locale) },
          :long_ordinal => lambda { |clazz| clazz.pattern_formatter("%B #{time.day.ordinalize}, %Y %H:%M") },
          :rfc822       => lambda { |clazz| clazz.pattern_formatter("%a, %d %b %Y %H:%M:%S #{time.formatted_offset(false)}") },
          :httpdate     => lambda { |clazz| clazz.pattern_formatter("EEE, dd MMM yyyy HH:mm:ss z", "GMT") }
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