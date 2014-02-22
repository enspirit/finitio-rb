module Qrb
  module Syntax
    module Support

      def resolve_ruby_const(name)
        name.split('::').inject(::Kernel){|mod,const|
          mod.const_get(const)
        }
      end

    end # module Support
  end # module Syntax
end # module Qrb
