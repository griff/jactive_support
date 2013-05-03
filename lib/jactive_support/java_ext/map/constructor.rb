module JactiveSupport #:nodoc:
  module JavaExtensions #:nodoc:
    module Map #:nodoc:
      module Constructor
        def self.included(other_mod)
          other_mod.extend(ClassExtensions)
        end
        
        module ClassExtensions
          def [](*args)
            r = self.new
            if args.size == 1 && ( args.first.respond_to?(:to_ary) || args.first.respond_to?(:to_hash) )
              args = args.first
              if args.respond_to?(:to_ary)
                args = args.to_ary
              elsif args.respond_to?(:to_hash)
                args = args.to_hash
              end
              args.each do |e|
                next unless e.respond_to? :to_ary
                e = e.to_ary
                r.put(e.shift, e.shift) if (1..2).include?(e.size)
              end
            else
              raise ArgumentError, "odd number of arguments for constructor" unless (args.size % 2) == 0
              args.each_slice(2) {|key,val| r.put(key,val)}
            end
            
            r
          end
        end
      end
    end
  end
end