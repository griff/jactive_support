class Hash
  def Hash.with_keys_values(keys, values)
    raise ArgumentError, "Unmatching sizes #{keys.size} != #{values.size}" unless keys.size == values.size
    #Hash[keys.zip(values).flatten]
    ret = Hash.new
    keys.each_with_index{|key, idx| ret[key] = values[idx]}
    ret
  end
end