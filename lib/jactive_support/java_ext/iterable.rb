require 'jactive_support/java_ext/iterator'

module java::lang::Iterable
  if RUBY_VERSION >= '1.9'
    FrozenError = RuntimeError
  else
    FrozenError = TypeError
  end
  
  def iterate
    return enum_for(:iterate) unless block_given?
    it = iterator
    while it.next?
      ob = it.next
      yield(it,ob)
    end
  end

  def delete_if
    raise FrozenError, "can't modify frozen iterable" if frozen?
    return enum_for(:delete_if) unless block_given?
    iterate do |it,ob|
      it.remove if yield(ob)
    end
    self
  end
  
  def reject!
    raise FrozenError, "can't modify frozen iterable" if frozen?
    return enum_for(:reject!) unless block_given?
    ret = nil
    iterate do |it,ob|
      if yield(ob)
        it.remove 
        ret = self
      end
    end
    ret
  end
  
  def shift(*args)
    raise ArgumentError, "wrong # of arguments(#{args.size} for 1)" if args.size > 1
    raise FrozenError, "can't modify frozen iterable" if frozen?
    it = iterator
    if args.size == 1
      n = args.first
      raise TypeError, "Can't convert #{n} into Integer" unless n.respond_to?(:to_int)
      n = n.to_int
      raise TypeError, "#to_int should return Integer" unless n.kind_of?(Integer)
      raise ArgumentError, "negative array size" if n < 0
      ret = []
      while n > 0 && it.next?
        ret << it.next
        it.remove
        n -= 1
      end
      ret
    elsif it.next?
      ret = it.next 
      it.remove
      ret
    end
  end
  
  def empty?
    !iterator.next?
  end
  
  def clear
    raise FrozenError, "can't modify frozen iterable" if frozen?
    iterate {|it, o| it.remove}
    self
  end
end