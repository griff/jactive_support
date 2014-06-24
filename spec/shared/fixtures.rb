require 'i18n'

def enumerator_class
  [].each.class
end

def ruby_bug(*args)
  yield
end

I18n.locale = :en
java::util::Locale.default = java::util::Locale.new('en')
def setup_date_translations
  I18n.backend.store_translations :en, {
    :java_date => {
      :formats => {
        :default => 'HH:mm:ss.SSS dd/MM/yyyy',
        :short => 'dd. MMM',
        :long => 'dd. MMMM yyyy',
      },
    },
    :sql_date => {
      :formats => {
        :default => 'dd/MM/yyyy'
      }
    }
  }
  I18n.backend.store_translations :de, {
    :java_date => {
      :formats => {
        :default => 'HH:mm:ss.SSS dd.MM.yyyy',
        :short => 'dd. MMM',
        :long => 'dd. MMMM yyyy',
      },
    }
  }
  I18n.backend.store_translations :fr, {
    :java_date => {
      :formats => {
        :default => 'HH:mm:ss.SSS dd.MM.yyyy',
        :input => 'HH:mm:ss.SSS dd.MM.yy',
      },
    }
  }
  I18n.backend.store_translations :sv, {
    :java_date => {
      :formats => {
        :default => 'HH:mm:ss.SSS dd-MM-yy',
        :output => 'HH:mm:ss.SSS dd-MM-yyyy',
      },
    }
  }
end
