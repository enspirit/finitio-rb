module Finitio
  module Syntax
    module NamedConstraint
      extend AstNode

      capture :expression
      capture_str :constraint_name

      def compile(var_name)
        { constraint_name.to_sym => expression.compile(var_name) }
      end

      def to_ast(var_name)
        [ :constraint,
          constraint_name,
          [:fn, [:parameters, var_name], [:source, expression.to_str.strip]] ]
      end

    end # module NamedConstraint
  end # module Syntax
end # module Finitio
