module Finitio
  module Syntax
    module SubType
      extend AstNode

      capture :rel_type, :constraint_def

      def compile(factory)
        s = rel_type.compile(factory)
        c = constraint_def.compile(factory)
        factory.subtype(s, c)
      end

      def to_ast
        [:sub_type, rel_type.to_ast] + constraint_def.to_ast
      end

    end # module SubType
  end # module Syntax
end # module Finitio
