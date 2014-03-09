module Qrb
  module Syntax
    module ExternalPair
      include Support

      def compile(factory)
        clazz = resolve_ruby_const(builtin_type_name.to_s)
        [ clazz.method(:dress), clazz.method(:undress) ]
      end

      def to_ast
        [ :external_pair, builtin_type_name.to_s ]
      end

    end # module ExternalPair
  end # module Syntax
end # module Qrb
