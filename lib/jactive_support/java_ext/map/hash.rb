module JactiveSupport #:nodoc:
  module JavaExtensions #:nodoc:
    module Map #:nodoc:
      module Hash
        def self.included(other_mod)
          other_mod.send :alias_method, :has_key?, :contains_key?
          other_mod.send :alias_method, :key?, :has_key?
          other_mod.send :alias_method, :include?, :has_key?
          other_mod.send :alias_method, :member?, :has_key?
          other_mod.send :alias_method, :has_value?, :contains_value?
          other_mod.send :alias_method, :value?, :has_value?
          other_mod.send :alias_method, :update, :merge!
        end
        
        def each
          entry_set.each do |e|
            yield [e.key, e.value]
          end
          self
        end
        
        def each_pair
          entry_set.each do |e|
            yield e.key, e.value
          end
          self
        end
        
        def contains_key?(key)
          containsKey(key)
        end
        
        def contains_value?(value)
          containsValue(value)
        end
        
        def length
          size
        end
        
        def delete_if(&block)
          entry_set.iterate do |it, entry|
            it.remove if yield(entry.key, entry.value)
          end
          self
        end
        
        def each_key(&block)
          key_set.each(&block)
          self
        end
        
        def each_value(&block)
          values.each(&block)
          self
        end
        
        def delete(key)
          if block_given? && !key?(key)
            yield key
          else
            remove(key)
          end
        end
        
        def fetch(key,default=nil)
          return get(key) if key?(key)
          raise IndexError unless default || block_given?
          return default if default
          yield key
        end
        
        def index(value)
          ret = entry_set.find {|entry| entry.value == value}
          return nil unless ret
          ret.key
        end
        
        def invert
          ret = nil
          begin
            ret = dup
            ret.clear
            ret
          rescue
            ret = ::Hash.new
          end
          each_pair {|key,value| ret[value] = key}
          ret
        end
        
        def keys
          key_set.to_a
        end
        
        def merge(other_hash,&block)
          dup.merge!(other_hash,&block)
        end
        
        def merge!(other_hash)
          if block_given?
            other_hash.each_pair do |key, newval|
              if has_key?(key)
                oldval = get(key)
                newval = yield(key,oldval,newval)
              end
              put(key, newval)
            end
          else
            put_all(other_hash.to_java_map)
          end
          self
        end
        
        def to_hash
          ret = ::Hash.new
          each_pair {|key,value| ret[key] = value}
          ret
        end
        
        def reject(&block)
          dup.delete_if(&block)
        end
        
        def reject!
          ret = nil
          entry_set.iterate do |it, entry|
            if yield(entry.key, entry.value)
              it.remove
              ret = self
            end
          end
          ret
        end
        
        def replace(other_hash)
          clear
          merge!(other_hash)
        end
        
        def values_at(*keys)
          keys.inject([]) do |memo,key|
            memo.push(get(key))
          end
        end
        
        def dup
          clone
        end
      end
    end
  end
end