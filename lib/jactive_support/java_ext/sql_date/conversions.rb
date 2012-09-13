require 'active_support/core_ext/object/blank'

module JactiveSupport #:nodoc:
  module JavaExtensions #:nodoc:
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
        
        def to_java_sqldate
          self
        end
        
        def acts_like_time?
          false
        end
      end
    end
  end
end