module JactiveSupport #:nodoc:
  module CoreExtensions #:nodoc:
    module Date #:nodoc:
      module Calculations
        CALCULATION_FIELDS = {
          :years => ::Java::JavaUtil::Calendar::YEAR,
          :months => ::Java::JavaUtil::Calendar::MONTH,
          :weeks => ::Java::JavaUtil::Calendar::WEEK_OF_YEAR,
          :days => ::Java::JavaUtil::Calendar::DAY_OF_MONTH,
          :hours => ::Java::JavaUtil::Calendar::HOUR_OF_DAY,
          :minutes => ::Java::JavaUtil::Calendar::MINUTE,
          :seconds => ::Java::JavaUtil::Calendar::SECOND,
          :millis => ::Java::JavaUtil::Calendar::MILLISECOND
        }
        
        def advance(options)
          cal = ::Java::JavaUtil::Calendar.getInstance
          cal.setTime(self)
          options.each do |field, value|
            cal.add(CALCULATION_FIELDS[field], value)
          end
          cal.getTime
        end
      end
    end
  end
end
