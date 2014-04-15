module Finitio
  module Syntax
    module StructType
      extend AstNode

      def compile(factory)
        component_types = captures[:type].map{|x| x.compile(factory) }
        factory.struct(component_types)
      end

      def to_ast
        captures[:type].map(&:to_ast).unshift(:struct_type)
      end

    end # module StructType
  end # module Syntax
end # module Finitio
