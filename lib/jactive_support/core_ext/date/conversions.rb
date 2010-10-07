module JactiveSupport #:nodoc:
  module CoreExtensions #:nodoc:
    module Date #:nodoc:
      # Converting dates to formatted strings, times, and datetimes.
      module Conversions
        DATE_FORMATS = {
          :db           => "yyyy-MM-dd HH:mm:ss.SSS",
          :number       => "YYYMMddHHmmssSSS",
          :time         => "HH:mm",
          :short        => "%d %b %H:%M",
          :long         => "%B %d, %Y %H:%M",
          :long_ordinal => lambda { |time| time.format_date("%B #{time.day.ordinalize}, %Y %H:%M") },
          :rfc822       => lambda { |time| time.format_date("%a, %d %b %Y %H:%M:%S #{time.formatted_offset(false)}") },
          :httpdate     => lambda { |time| time.format_date("EEE, dd MMM yyyy HH:mm:ss z", "GMT") }
        }

        def self.included(base) #:nodoc:
          base.class_eval do
            alias_method :to_default_s, :to_s
            alias_method :to_s, :to_formatted_s
          end
        end

        # Converts to a formatted string. See DATE_FORMATS for builtin formats.
        #
        # This method is aliased to <tt>to_s</tt>.
        #
        #   time = Time.now                     # => Thu Jan 18 06:10:17 CST 2007
        #
        #   time.to_formatted_s(:time)          # => "06:10:17"
        #   time.to_s(:time)                    # => "06:10:17"
        #
        #   time.to_formatted_s(:db)            # => "2007-01-18 06:10:17"
        #   time.to_formatted_s(:number)        # => "20070118061017"
        #   time.to_formatted_s(:short)         # => "18 Jan 06:10"
        #   time.to_formatted_s(:long)          # => "January 18, 2007 06:10"
        #   time.to_formatted_s(:long_ordinal)  # => "January 18th, 2007 06:10"
        #   time.to_formatted_s(:rfc822)        # => "Thu, 18 Jan 2007 06:10:17 -0600"
        #
        # == Adding your own time formats to +to_formatted_s+
        # You can add your own formats to the Time::DATE_FORMATS hash.
        # Use the format name as the hash key and either a strftime string
        # or Proc instance that takes a time argument as the value.
        #
        #   # config/initializers/time_formats.rb
        #   Time::DATE_FORMATS[:month_and_year] = "%B %Y"
        #   Time::DATE_FORMATS[:short_ordinal] = lambda { |time| time.strftime("%B #{time.day.ordinalize}") }
        def to_formatted_s(format = :db)
          return to_default_s unless formatter = self.class::DATE_FORMATS[format]
          formatter.respond_to?(:call) ? formatter.call(self).to_s : format_date(formatter)
        end
        
        def format_date(format, timezone=nil)
          formatter = ::Java::JavaText::SimpleDateFormat.new(format)
          timezone = ::Java::JavaUtil::TimeZone.getTimeZone(timezone) unless timezone.nil? || timezone.is_a?(::Java::JavaUtil::TimeZone)
          formatter.setTimeZone(timezone) if timezone
          formatter.format(self)
        end


        # Converts a java.util.Date object to a ruby Date, dropping hour, minute, and second precision.
        #
        #   my_time = java.util.Date.new  # => Mon Nov 12 22:59:51 -0500 2007
        #   my_time.to_date     # => Mon, 12 Nov 2007
        def to_date
          to_time.to_date
        end

        # Converts a java.util.Date instance to a Time.
        #
        # ==== Examples
        #   date = java.util.Date.new  # => Mon Nov 12 22:59:51 -0500 2007
        #   date.to_time               # => Mon Nov 12 22:59:51 -0500 2007
        def to_time
          ::Time.at(self.getTime/1000)
        end

        # Converts a java.util.Date instance to a Ruby DateTime instance, preserving UTC offset.
        #
        #   my_time = Time.now    # => Mon Nov 12 23:04:21 -0500 2007
        #   my_time.to_datetime   # => Mon, 12 Nov 2007 23:04:21 -0500
        #
        #   your_time = Time.parse("1/13/2009 1:13:03 P.M.")  # => Tue Jan 13 13:13:03 -0500 2009
        #   your_time.to_datetime                             # => Tue, 13 Jan 2009 13:13:03 -0500
        def to_datetime
          to_time.to_datetime
        end
        
        def httpdate
          to_formatted_s(:httpdate)
        end
      end
    end
  end
end