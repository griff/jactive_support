require 'active_support/concern'

module JactiveSupport
  # Makes a class support localize and class parse method
  # It expects class 3 methods be implemented on the class.
  #   i18n_scope - The scope to use for translations
  #   pattern_formatter(format, locale) - returns a formatter based on a pattern
  #   default_formatter(locale) - returns a default formatter when the format is blank
  module Localize
    extend ActiveSupport::Concern

    included do
      class << self
        alias :parse_original :parse
        alias :parse :parse_i18n
      end
    end

    module ClassMethods
      def i18n_formatter(options = {})
        format = options[:format] || :default
        locale = options.fetch(:locale, ::I18n.locale)
        if Symbol === format
          key  = format
          options = options.merge(raise: true, object: self)
          format = ::I18n.t("#{self.i18n_scope}.formats.#{key}", options)
        end
        if format.blank?
          formatter = default_formatter(locale)
        else
          formatter = pattern_formatter(format, locale)
        end

        if options[:time_zone] && formatter.respond_to?(:time_zone)
          formatter.time_zone = options[:time_zone].to_java_time_zone
        end

        formatter
      end

      def parse_i18n(str, options = {})
        unless options[:format]
          defaults = [
            :"#{self.i18n_scope}.formats.default", 
            options.delete(:default)]
          defaults.compact!
          defaults.flatten!
          options[:default] = defaults unless defaults.empty?
          options[:format] = :input
        end
        formatter = i18n_formatter(options)
        formatter.parse(str)
      end
    end

    def localize(options = {})
      unless options[:format]
        defaults = [
          :"#{self.class.i18n_scope}.formats.default", 
          options.delete(:default)]
        defaults.compact!
        defaults.flatten!
        options[:default] = defaults unless defaults.empty?
        options[:format] = :output
      end
      formatter = self.class.i18n_formatter(options)
      formatter.format(self)
    end
  end
end