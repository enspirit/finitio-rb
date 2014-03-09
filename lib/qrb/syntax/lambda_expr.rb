module Qrb
  module Syntax
    module LambdaExpr

      def compile(factory)
        expression.compile(var_name)
      end

      def to_ast
        [:fn, [:parameters, var_name.to_s], [:source, expression.to_s.strip]]
      end

    end # module LambdaExpr
  end # module Syntax
end # module Qrb
