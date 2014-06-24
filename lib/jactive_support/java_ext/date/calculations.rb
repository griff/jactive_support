class java::util::Date
  CALCULATION_FIELDS = {
    years: java::util::Calendar::YEAR,
    months: java::util::Calendar::MONTH,
    weeks: java::util::Calendar::WEEK_OF_YEAR,
    days: java::util::Calendar::DAY_OF_MONTH,
    hours: java::util::Calendar::HOUR_OF_DAY,
    minutes: java::util::Calendar::MINUTE,
    seconds: java::util::Calendar::SECOND,
    millis: java::util::Calendar::MILLISECOND
  }

  def advance(options)
    cal = java::util::Calendar.instance
    cal.time = self
    options.each do |field, value|
      cal.add(CALCULATION_FIELDS[field], value)
    end
    cal.time
  end
  
  def age(since = Date.new)
    difference(:years, since)
  end
  
  def difference(field = :years, since = Date.new)
    local_date = org::joda::time::LocalDate.fromDateFields(self)
    since_date = org::joda::time::LocalDate.fromDateFields(since)
    if field == :days
      return org::joda::time::Days.daysBetween(local_date, since_date).days
    elsif field == :months
      return org::joda::time::Months.monthsBetween(local_date, since_date).months
    else
      return org::joda::time::Years.yearsBetween(local_date, since_date).years
    end
  end
end
