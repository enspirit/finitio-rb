module Finitio
  module Syntax
    module HighOrderVars
      include Node

      def compile(system)
        captures[:type_name].map{|c| c.to_s }
      end

      def to_ast(var_name)
        [ :high_order_vars, captures[:type_name].map{|c| c.to_s } ]
      end

    end # module HighOrderVars
  end # module Syntax
end # module Finitio
