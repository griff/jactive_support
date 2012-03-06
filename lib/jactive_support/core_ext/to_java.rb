class Object
  def to_java(cls=nil)
    if cls.is_a?(Symbol) && respond_to?("to_java_#{cls}")
      send "to_java_#{cls}"
    else
      super
    end
  end
end