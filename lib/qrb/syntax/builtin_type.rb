module Qrb
  module Syntax
    module BuiltinType

      def compile(factory)
        clazz = ::Kernel.const_get(builtin_type_name)
        factory.builtin(clazz)
      end

    end # module BuiltinType
  end # module Syntax
end # module Qrb
