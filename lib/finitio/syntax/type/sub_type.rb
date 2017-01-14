module Finitio
  module Syntax
    module SubType
      include Node

      capture :rel_type, :constraint_def

      def compile(factory)
        s = rel_type.compile(factory)
        if c = constraint_def
          factory.subtype(s, c.compile(factory))
        else
          s
        end
      end

      def to_ast
        if c = constraint_def
          [:sub_type, rel_type.to_ast] + constraint_def.to_ast
        else
          rel_type.to_ast
        end
      end

    end # module SubType
  end # module Syntax
end # module Finitio
