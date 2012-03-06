require 'jactive_support/java_ext/locale'

Locale = java::util::Locale

class NilClass
  def to_locale
    java::util::Locale.current_locale
  end
end

class String
  # Returns the java.util.Locale that maches this string
  def to_locale
    java::util::Locale.new(self)
  end
end

class Symbol
  def to_locale
    to_s.to_locale
  end
end