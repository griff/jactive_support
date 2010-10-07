module java::lang::Iterable
  #include Enumerable JRuby already does this
  
  def iterate
    it = iterator
    while it.next?
      ob = it.next
      yield(it,ob)
    end
  end
=begin comment
  JRuby already contains a simular expression
  def each
    it = iterator
    while it.next?
      yield it.next
    end
  end
=end

  def delete_if
    iterate do |it,ob|
      it.remove if yield(ob)
    end
    self
  end
  alias :reject! :delete_if
  
  def clear
    iterate {|it, o| it.remove}
    self
  end
end