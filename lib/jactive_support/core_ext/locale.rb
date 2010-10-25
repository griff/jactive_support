class Java::JavaUtil::Locale
  def to_locale
    self
  end
  
  def human_name
    getDisplayLanguage(I18n.locale.to_locale)
  end
end

class NilClass
  def to_locale
    Java::JavaUtil::Locale.getDefault
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