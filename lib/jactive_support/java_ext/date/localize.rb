require 'jactive_support/localize'
require 'jactive_support/java_ext/date/formatters'
require 'jactive_support/core_ext/to_java_time_zone'
require 'i18n'

class java::util::Date
  include JactiveSupport::Localize

  def self.i18n_scope
    :java_date
  end
end