module Finitio
  module Syntax
    module SetType
      extend AstNode

      capture :type

      def compile(factory)
        elm_type = type.compile(factory)
        factory.set(elm_type)
      end

      def to_ast
        [:set_type, type.to_ast]
      end

    end # module SetType
  end # module Syntax
end # module Finitio
