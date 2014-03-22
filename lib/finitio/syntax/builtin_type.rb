module Finitio
  module Syntax
    module BuiltinType
      extend AstNode
      include Support

      capture :builtin_type_name

      def compile(factory)
        clazz = resolve_ruby_const(builtin_type_name.to_s)
        factory.builtin(clazz)
      end

      def to_ast
        [:builtin_type, builtin_type_name.to_s]
      end

    end # module BuiltinType
  end # module Syntax
end # module Finitio
