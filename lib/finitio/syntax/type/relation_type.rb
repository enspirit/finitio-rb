module Finitio
  module Syntax
    module RelationType
      include Node

      capture :heading

      def compile(factory)
        factory.send(kind, heading.compile(factory))
      end

      def to_ast
        [ :"#{kind}_type", heading.to_ast ]
      end

    private

      def kind
        heading.multi? ? :multi_relation : :relation
      end

    end # module RelationType
  end # module Syntax
end # module Finitio
