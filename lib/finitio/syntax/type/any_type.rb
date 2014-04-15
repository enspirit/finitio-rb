module Finitio
  module Syntax
    module AnyType
      include Node

      def compile(factory)
        factory.any
      end

      def to_ast
        [:any_type]
      end

    end # module AnyType
  end # module Syntax
end # module Finitio
