module Finitio
  module Syntax
    module HighOrderTypeInstantiation
      include Node

      capture :high
      capture :vars

      def compile(system)
        target = system.fetch(high.to_s){
          raise Error, "No such type `#{high.to_s}`"
        }
        raise "#{high} is not a high order type" unless target.is_a?(HighOrderType)

        subs = vars.compile(system).map{|low|
          system.fetch(low.to_s) {
            raise Error, "No such type `#{low.to_s}`"
          }
        }
        target.instantiate(system, subs)
      end

      def to_ast
        [:high_order_type_instantiation, high.to_s, lows.to_s]
      end

    end # module HighOrderTypeInstantiation
  end # module Syntax
end # module Finitio
