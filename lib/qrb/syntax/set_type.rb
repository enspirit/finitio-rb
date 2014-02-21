module Qrb
  module Syntax
    module SetType

      def compile(builder)
        elm_type = type.compile(builder)
        builder.set(elm_type)
      end

    end # module SetType
  end # module Syntax
end # module Qrb
