module Finitio
  module Syntax
    module Expression
      include Node

      def compile(var_name)
        expr = "->(#{var_name}){ #{to_str} }"
        ::Kernel.eval(expr)
      end

    end # module Expression
  end # module Syntax
end # module Finitio
