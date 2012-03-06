class java::util::Locale
  def self.current_locale
    self.getDefault
  end

  def self.current_locale=(l)
    self.setDefault(l.to_locale)
  end
  
  def to_locale
    self
  end
  
  def human_name
    l = Locale.current_locale
    display_country = country.blank? ? "" : " (#{getDisplayCountry(l)})"
    display_variant = variant.blank? ? "" : " - #{getDisplayVariant(l)}"
    "#{getDisplayLanguage(l)}#{display_country}#{display_variant}"
  end
  
  def inspect
    "Locale[#{human_name}]"
  end
  
  def to_sym
    to_s.to_sym
  end
end
