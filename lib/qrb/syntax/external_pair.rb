module Qrb
  module Syntax
    module ExternalPair
      include Support

      def compile(factory)
        clazz = resolve_ruby_const(builtin_type_name.to_s)
        [ clazz.method(:dress), clazz.method(:undress) ]
      end

    end # module ExternalPair
  end # module Syntax
end # module Qrb
