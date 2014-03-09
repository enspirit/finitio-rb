module Qrb
  module Syntax
    module TupleType

      def compile(factory)
        factory.tuple(heading.compile(factory))
      end

      def to_ast
        [:tuple_type, heading.to_ast]
      end

    end # module TupleType
  end # module Syntax
end # module Qrb
