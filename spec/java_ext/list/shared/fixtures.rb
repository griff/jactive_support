require File.expand_path('../../../../shared/version', __FILE__)
require File.expand_path('../../../../shared/fixtures', __FILE__)

class List < java::util::ArrayList
  def self.[](*args)
    new(args)
  end
end

module ListSpecs
  def self.frozen_list
    frozen_array = List[1,2,3]
    frozen_array.freeze
    frozen_array
  end

  def self.empty_frozen_list
    frozen_array = List[]
    frozen_array.freeze
    frozen_array
  end

  def self.recursive_list
    a = List[1, 'two', 3.0]
    5.times { a << a }
    a
  end

  def self.empty_recursive_list
    a = List[]
    a << a
    a
  end
end
