module Qrb
  module Syntax
    module Expression

      def compile(var_name)
        expr = "->(#{var_name}){ #{self} }"
        ::Kernel.eval(expr)
      end

    end # module Expression
  end # module Syntax
end # module Qrb
