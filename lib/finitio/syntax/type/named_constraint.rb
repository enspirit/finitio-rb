module Finitio
  module Syntax
    module NamedConstraint
      include Node

      capture :expression
      capture_str :constraint_name

      def compile(var_name)
        p = expression.compile(var_name)
        n = constraint_name.to_sym
        m = metadata
        Constraint.new(p, n, metadata)
      end

      def to_ast(var_name)
        [ :constraint,
          constraint_name,
          [:fn, [:parameters, var_name], [:source, expression.to_str.strip]] ]
      end

    end # module NamedConstraint
  end # module Syntax
end # module Finitio
