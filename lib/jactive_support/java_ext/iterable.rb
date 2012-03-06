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
  
  def clear
    raise FrozenError, "can't modify frozen iterable" if frozen?
    iterate {|it, o| it.remove}
    self
  end
end