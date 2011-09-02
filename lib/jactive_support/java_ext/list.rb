module java::util::List
  def inspect
    content = map{|e| e.inspect}.join(', ')
    "JavaList[#{content}]"
  end

  def iterate
    it = listIterator
    while it.next?
      ob = it.next
      yield(it,ob)
    end
  end  

  def map!(&block)
    iterate{|it, ob| it.set(yield(ob))}
  end
  
  def push(*args)
    args.each{|a| add(a)}
    self
  end

  def last
    self.get(size-1) if size > 0 
  end
end