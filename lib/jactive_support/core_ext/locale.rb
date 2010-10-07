class Java::JavaUtil::Locale
  def to_locale
    self
  end
  
  def human_name
    getDisplayLanguage(I18n.locale.to_locale)
  end
end