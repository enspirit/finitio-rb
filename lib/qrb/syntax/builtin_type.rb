module Qrb
  module Syntax
    module BuiltinType

      def compile(factory)
        name  = builtin_type_name.to_s
        clazz = name.split('::')
                    .inject(::Kernel){|mod,const| mod.const_get(const) }
        factory.builtin(clazz)
      end

    end # module BuiltinType
  end # module Syntax
end # module Qrb
