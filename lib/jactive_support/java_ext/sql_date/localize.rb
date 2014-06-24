require 'jactive_support/java_ext/date/localize'

class java::sql::Date
  def self.i18n_scope
    :sql_date
  end

  def self.default_formatter(locale)
    date_instance(:default, locale)
  end

  def self.parse(str, options = {})
    date = super
    self.new(date.time)
  end

  def self.parse_i18n(str, options = {})
    date = super
    self.new(date.time)
  end
end