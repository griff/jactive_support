require 'active_support/dependencies'
require 'java'
java.lang.Exception.class_eval { include ::ActiveSupport::Dependencies::Blamable }
