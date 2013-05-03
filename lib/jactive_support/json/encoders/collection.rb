module java::util::Collection #:nodoc:

  # Returns a JSON string representing the Array. +options+ are passed to each element.
  def to_json(options = nil) #:nodoc:
    "[#{map { |value| ActiveSupport::JSON.encode(value, options) } * ','}]"
  end

  def as_json(options = nil) #:nodoc:
    self
  end

end