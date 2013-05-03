require 'active_support/inflector'

module ActiveSupport
  module Inflector
    def constantize_with_jruby(camel_cased_word)
      names = camel_cased_word.split('::')
      names.shift if names.empty? || names.first.empty?

      if names.first == "Java" && names.size == 3
        last = names.pop
        constantize_without_jruby(names.join('::')).__send__ last
      else
        constantize_without_jruby(camel_cased_word)
      end
    end
    alias :constantize_without_jruby :constantize
    alias :constantize :constantize_with_jruby
  end
end