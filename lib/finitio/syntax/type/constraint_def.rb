module Finitio
  module Syntax
    module ConstraintDef
      include Node

      capture :var_name, :constraints

      def compile(factory)
        constraints.compile(var_name.to_s)
      end

      def to_ast
        constraints.to_ast(var_name.to_s)
      end

    end # module ConstraintDef
  end # module Syntax
end # module Finitio
