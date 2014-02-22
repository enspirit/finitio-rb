module Qrb
  module Syntax
    module SetType

      def compile(factory)
        elm_type = type.compile(factory)
        factory.set(elm_type)
      end

    end # module SetType
  end # module Syntax
end # module Qrb
