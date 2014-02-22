module Qrb
  module Syntax
    module Attribute

      def compile(factory)
        factory.attribute(attribute_name.to_sym, type.compile(factory))
      end

    end # module BuiltinType
  end # module Syntax
end # module Qrb
