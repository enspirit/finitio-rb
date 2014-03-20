module Finitio
  module Syntax
    module NamedConstraint

      def compile(var_name)
        { constraint_name.to_sym => expression.compile(var_name) }
      end

      def to_ast(var_name)
        [ :constraint,
          constraint_name.to_s,
          [:fn, [:parameters, var_name], [:source, expression.to_s.strip]] ]
      end

    end # module NamedConstraint
  end # module Syntax
end # module Finitio
