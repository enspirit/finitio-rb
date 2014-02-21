module Qrb
  module Syntax
    module SubType

      def compile(builder)
        s = rel_type.compile(builder)
        c = constraint_def.compile(builder)
        builder.subtype(s, c)
      end

    end # module SubType
  end # module Syntax
end # module Qrb
