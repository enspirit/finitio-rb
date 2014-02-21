module Qrb
  module Syntax
    module ConstraintDef

      def compile(builder)
        expr = "->(#{var_name}){ #{expression} }"
        ::Kernel.eval(expr)
      end

    end # module ConstraintDef
  end # module Syntax
end # module Qrb
