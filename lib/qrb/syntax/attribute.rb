module Qrb
  module Syntax
    module Attribute

      def compile(builder)
        builder.attribute(attribute_name.to_sym, type.compile(builder))
      end

    end # module BuiltinType
  end # module Syntax
end # module Qrb
