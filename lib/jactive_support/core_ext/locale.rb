class Java::JavaUtil::Locale
  def self.current_locale
    Java::JavaUtil::Locale.getDefault
  end
  
  def to_locale
    self
  end
  
  def human_name
    getDisplayLanguage(I18n.locale.to_locale)
  end
  
  def inspect
    "Locale[#{human_name}]"
  end
  
  def to_sym
    to_s.to_sym
  end
end

class NilClass
  def to_locale
    Java::JavaUtil::Locale.current_locale
  end
end

class String
  # Returns the java.util.Locale that maches this string
  def to_locale
    Java::JavaUtil::Locale.new(self)
  end
end

class Symbol
  def to_locale
    to_s.to_locale
  end
end