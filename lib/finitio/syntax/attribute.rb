module Finitio
  module Syntax
    module Attribute

      def multiplicity
        captures[:multiplicity].first
      end

      def optional?
        multiplicity == ':?'
      end

      def required?
        multiplicity == ':'
      end

      def compile(factory)
        factory.attribute(attribute_name.to_sym, type.compile(factory), required?)
      end

      def to_ast
        ast = [:attribute, attribute_name.to_s, type.to_ast]
        ast << false unless required?
        ast
      end

    end # module BuiltinType
  end # module Syntax
end # module Finitio
