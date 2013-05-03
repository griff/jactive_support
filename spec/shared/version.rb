class SpecVersion
  # If beginning implementations have a problem with this include, we can
  # manually implement the relational operators that are needed.
  include Comparable

  # SpecVersion handles comparison correctly for the context by filling in
  # missing version parts according to the value of +ceil+. If +ceil+ is
  # +false+, 0 digits fill in missing version parts. If +ceil+ is +true+, 9
  # digits fill in missing parts. (See e.g. VersionGuard and BugGuard.)
  def initialize(version, ceil = false)
    @version = version
    @ceil    = ceil
    @integer = nil
  end

  def to_s
    @version
  end

  def to_str
    to_s
  end

  # Converts a string representation of a version major.minor.tiny.patchlevel
  # to an integer representation so that comparisons can be made. For example,
  # "1.8.6.77" < "1.8.6.123" would be false if compared as strings.
  def to_i
    unless @integer
      major, minor, tiny, patch = @version.split "."
      if @ceil
        tiny = 99 unless tiny
        patch = 9999 unless patch
      end
      parts = [major, minor, tiny, patch].map { |x| x.to_i }
      @integer = ("1%02d%02d%02d%04d" % parts).to_i
    end
    @integer
  end

  def to_int
    to_i
  end

  def <=>(other)
    if other.respond_to? :to_int
      other = Integer other
    else
      other = SpecVersion.new(String(other)).to_i
    end

    self.to_i <=> other
  end
end

class VersionGuard
  @@ruby_version_override = nil

  def self.ruby_version_override=(version)
    @@ruby_version_override = version
  end

  def self.ruby_version_override
    @@ruby_version_override
  end

  # Returns a partial Ruby version string based on +which+. For example,
  # if RUBY_VERSION = 8.2.3 and RUBY_PATCHLEVEL = 71:
  #
  #  :major  => "8"
  #  :minor  => "8.2"
  #  :tiny   => "8.2.3"
  #  :teeny  => "8.2.3"
  #  :full   => "8.2.3.71"
  def self.ruby_version(which = :minor)
    case which
    when :major
      n = 1
    when :minor
      n = 2
    when :tiny, :teeny
      n = 3
    else
      n = 4
    end

    patch = RUBY_PATCHLEVEL.to_i
    patch = 0 if patch < 0
    version = "#{ruby_version_override || RUBY_VERSION}.#{patch}"
    version.split('.')[0,n].join('.')
  end
  
  def initialize(version)
    case version
    when String
      @version = SpecVersion.new version
    when Range
      a = SpecVersion.new version.first
      b = SpecVersion.new version.last
      @version = version.exclude_end? ? a...b : a..b
    end
  end

  def ruby_version
    @ruby_version ||= SpecVersion.new self.class.ruby_version(:full)
  end

  def match?
    if Range === @version
      @version.include? ruby_version
    else
      ruby_version >= @version
    end
  end
end

class Object
  def ruby_version_is(*args)
    g = VersionGuard.new(*args)
    yield if g.match?
  end
end

puts "Ruby is " + VersionGuard.ruby_version(:full)
