module Finitio
  module Syntax
    module UnnamedConstraint
      include Node

      capture :expression

      def compile(var_name)
        p = expression.compile(var_name)
        n = nil
        m = metadata
        Constraint.new(p, n, m)
      end

      def to_ast(var_name)
        [ :constraint,
          "default",
          [:fn, [:parameters, var_name], [:source, expression.to_s.strip]] ]
      end

    end # module UnnamedConstraint
  end # module Syntax
end # module Finitio
