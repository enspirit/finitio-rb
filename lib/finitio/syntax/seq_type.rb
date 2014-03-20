module Finitio
  module Syntax
    module SeqType

      def compile(factory)
        elm_type = type.compile(factory)
        factory.seq(elm_type)
      end

      def to_ast
        [:seq_type, type.to_ast]
      end

    end # module SeqType
  end # module Syntax
end # module Finitio
