class Java::JavaUtil::Locale

  def to_json(options = {}) #:nodoc:
    ActiveSupport::JSON.encode(to_s)
  end
end