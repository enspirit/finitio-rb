module Qrb
  module Syntax
    module BuiltinType
      include Support

      def compile(factory)
        clazz = resolve_ruby_const(builtin_type_name.to_s)
        factory.builtin(clazz)
      end

    end # module BuiltinType
  end # module Syntax
end # module Qrb
