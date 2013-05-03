require File.expand_path('../../../../shared/version', __FILE__)
require File.expand_path('../../../../shared/fixtures', __FILE__)
require 'jactive_support/core_ext/to_java'
require 'jactive_support/core_ext/to_java_list'

class Itr
  class Iterator
    include java::util::Iterator
    
    def initialize(array)
      @array = array
      @next = 0
    end
    
    def hasNext
      @next < @array.size
    end
    
    def next
      raise java::util::NoSuchElementException.new('No next element available') unless hasNext
      @next += 1
      @array[@next-1]
    end
    
    def remove
      raise java::lang::IllegalStateException.new('Can not remove until after next is called') if @next == 0
      @next -= 1
      @array.delete_at(@next)
    end
  end
  
  def self.[](*args)
    new(args)
  end
  
  attr_reader :value 
  
  def initialize(arr)
    @value = arr
  end
  
  include java::lang::Iterable
  
  def iterator
    Iterator.new(@value)
  end
  
  def ==(o)
    o = o.to_a if o.respond_to?(:to_a)
    to_a == o
  end
  
  def to_a
    value
  end
  
  def <<(o)
    value << o
  end
  
  def [](*args)
    Itr.new(value[*args])
  end
end

module IterableSpecs
  def self.frozen_iterable
    frozen_array = Itr[1,2,3]
    frozen_array.freeze
    frozen_array
  end

  def self.empty_frozen_iterable
    frozen_array = Itr[]
    frozen_array.freeze
    frozen_array
  end

  def self.recursive_iterable
    a = Itr[1, 'two', 3.0]
    5.times { a << a }
    a
  end

  def self.empty_recursive_iterable
    a = Itr[]
    a << a
    a
  end
end
