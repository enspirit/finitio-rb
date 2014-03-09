module Qrb
  module Syntax
    module AnyType
      include Support

      def compile(factory)
        factory.any
      end

    end # module AnyType
  end # module Syntax
end # module Qrb
