module Qrb
  module Syntax
    module SeqType

      def compile(builder)
        elm_type = type.compile(builder)
        builder.seq(elm_type)
      end

    end # module SeqType
  end # module Syntax
end # module Qrb
