module Qrb
  module Syntax
    module SubType

      def compile(factory)
        s = rel_type.compile(factory)
        c = constraint_def.compile(factory)
        factory.subtype(s, c)
      end

    end # module SubType
  end # module Syntax
end # module Qrb
