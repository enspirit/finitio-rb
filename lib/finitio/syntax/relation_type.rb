module Finitio
  module Syntax
    module RelationType

      def compile(factory)
        factory.relation(heading.compile(factory))
      end

      def to_ast
        [:relation_type, heading.to_ast]
      end

    end # module RelationType
  end # module Syntax
end # module Finitio
