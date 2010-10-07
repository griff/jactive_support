class Module
  def define_class(name, base)
    module_eval <<-RUBY_EVAL, __FILE__, __LINE__ + 1
      class #{name} < ::#{base.name}
      end
    RUBY_EVAL
    const_get(name)
  end
end