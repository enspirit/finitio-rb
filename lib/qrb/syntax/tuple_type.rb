module Qrb
  module Syntax
    module TupleType

      def compile(builder)
        builder.tuple(heading.compile(builder))
      end

    end # module TupleType
  end # module Syntax
end # module Qrb
