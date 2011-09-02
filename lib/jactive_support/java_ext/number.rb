class java::lang::Number
  def self.number_format_instance(format=:default, locale=nil)
    case format
    when :number then ::Java::JavaText::NumberFormat.getNumberInstance(locale.to_locale)
    when :currency then ::Java::JavaText::NumberFormat.getCurrencyInstance(locale.to_locale)
    when :percent then ::Java::JavaText::NumberFormat.getPercentInstance(locale.to_locale)
    when :scientific then ::Java::JavaText::NumberFormat.getScientificInstance(locale.to_locale)
    when :integer then ::Java::JavaText::NumberFormat.getIntegerInstance(locale.to_locale)
    when :default then ::Java::JavaText::NumberFormat.getInstance(locale.to_locale)
    end
  end
  
  NUMBER_FORMATS = {
    :number => lambda {|time, locale| number_format_instance(:number, locale).format(time.to_primitive)},
    :currency => lambda {|time, locale| number_format_instance(:currency, locale).format(time.to_primitive)},
    :percent => lambda {|time, locale| number_format_instance(:percent, locale).format(time.to_primitive)},
    :scientific => lambda {|time, locale| number_format_instance(:scientific, locale).format(time.to_primitive)},
    :integer => lambda {|time, locale| number_format_instance(:integer, locale).format(time.to_primitive)},
    :default => lambda {|time, locale| number_format_instance(:default, locale).format(time.to_primitive)},
  }
  
  def to_formatted_s(format=:default, locale=nil)
    return to_default_s unless formatter = self.class::NUMBER_FORMATS[format]
    formatter.respond_to?(:call) ? (formatter.arity==2 ? formatter.call(self, locale) : formatter.call(self)).to_s : format_number(formatter)
  end
  alias :to_default_s :to_s
  alias :to_s :to_formatted_s

  def format_number(format, locale=nil)
    symbols = ::Java::JavaText::DecimalFormatSymbols.new(locale.to_locale)
    formatter = ::Java::JavaText::DecimalFormat.new(format, symbols)
    formatter.format(self)
  end
  
  def to_primitive
    self
  end
end

class java::lang::Byte
  #alias :to_default_s :to_s
  #alias :to_s :to_formatted_s
  
  alias :to_primitive :byte_value
end

class java::lang::Short
  #alias :to_default_s :to_s
  #alias :to_s :to_formatted_s

  alias :to_primitive :short_value
end

class java::lang::Integer
  #alias :to_default_s :to_s
  #alias :to_s :to_formatted_s

  alias :to_primitive :int_value
end

class java::lang::Long
  #alias :to_default_s :to_s
  #alias :to_s :to_formatted_s

  alias :to_primitive :long_value
end

class java::lang::Float
  #alias :to_default_s :to_s
  #alias :to_s :to_formatted_s

  alias :to_primitive :float_value
end

class java::lang::Double
  #alias :to_default_s :to_s
  #alias :to_s :to_formatted_s

  alias :to_primitive :double_value
end


#class Java::JavaMath::BigDecimal
#  alias :to_default_s :to_s
#  alias :to_s :to_formatted_s
#end

#class Java::JavaMath::BigInteger
#  alias :to_default_s :to_s
#  alias :to_s :to_formatted_s
#end
