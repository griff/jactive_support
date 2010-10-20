class String
  # Returns the java.util.Locale that maches this string
  def break
    self.to_s.gsub(/\n|\r\n?/, '<br>')
  end
end

class NilClass #:nodoc:
  def break
    self
  end
end