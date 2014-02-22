module Qrb
  module Syntax
    module TupleType

      def compile(factory)
        factory.tuple(heading.compile(factory))
      end

    end # module TupleType
  end # module Syntax
end # module Qrb
