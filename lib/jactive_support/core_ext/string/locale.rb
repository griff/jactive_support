class String
  # Returns the java.util.Locale that maches this string
  def to_locale
    Java::JavaUtil::Locale.new(self)
  end
end