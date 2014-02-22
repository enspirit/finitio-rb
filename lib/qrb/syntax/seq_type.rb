module Qrb
  module Syntax
    module SeqType

      def compile(factory)
        elm_type = type.compile(factory)
        factory.seq(elm_type)
      end

    end # module SeqType
  end # module Syntax
end # module Qrb
