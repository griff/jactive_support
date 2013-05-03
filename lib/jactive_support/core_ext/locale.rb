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
    if self =~ /^(.+)[-_](.+)[-_](.+)$/
      java::util::Locale.new($1, $2, $3)
    elsif self =~ /^(.+)[-_](.+)$/
      java::util::Locale.new($1, $2)
    else
      java::util::Locale.new(self)
    end
  end
end

class Symbol
  def to_locale
    to_s.to_locale
  end
end