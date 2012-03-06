require 'jactive_support/java_ext/list_iterator'

module java::util::List
  if RUBY_VERSION >= '1.9'
    FrozenError = RuntimeError
  else
    FrozenError = TypeError
  end
  
  def inspect
    content = map{|e| e.inspect}.join(', ')
    "JavaList[#{content}]"
  end

  def iterate
    return enum_for(:iterate) unless block_given?
    it = listIterator
    while it.next?
      ob = it.next
      yield(it,ob)
    end
  end  

  def map!
    raise FrozenError, "can't modify frozen iterable" if frozen?
    return enum_for(:map!) unless block_given?
    iterate{|it, ob| it.set(yield(ob))}
    self
  end
  alias :collect! :map!
  
  def push(*args)
    raise FrozenError, "can't modify frozen iterable" if frozen? && ( RUBY_VERSION >= '1.9' || args.size > 0 )
    args.each{|a| add(a)}
    self
  end

  def last(*args)
    raise ArgumentError, "wrong # of arguments(#{args.size} for 1)" if args.size > 1
    if args.size == 1
      n = args.first
      raise TypeError, "Can't convert #{n} into Integer" unless n.respond_to?(:to_int)
      n = n.to_int
      raise TypeError, "#to_int should return Integer" unless n.kind_of?(Integer)
      raise ArgumentError, "negative array size" if n < 0

      it = listIterator(size)
      ret = []
      while n > 0 && it.previous?
        ret.unshift it.previous
        n -= 1
      end
      ret
    elsif size > 0 
      self.get(size-1) 
    end
  end
  
  def clear
    raise FrozenError, "can't modify frozen list" if frozen?
    super
    self
  end
  
end