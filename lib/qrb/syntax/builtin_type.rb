module Qrb
  module Syntax
    module BuiltinType

      def compile(builder)
        clazz = ::Kernel.const_get(builtin_type_name)
        builder.builtin(clazz)
      end

    end # module BuiltinType
  end # module Syntax
end # module Qrb
