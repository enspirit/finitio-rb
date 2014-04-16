module Finitio
  module Syntax
    module Attribute
      include Node

      capture :type, :multiplicity
      capture_str :attribute_name

      def optional?
        multiplicity == ':?'
      end

      def required?
        multiplicity == ':'
      end

      def compile(factory)
        n = attribute_name.to_sym
        t = type.compile(factory)
        r = required?
        m = metadata
        factory.attribute(n, t, r, m)
      end

      def to_ast
        ast = [:attribute, attribute_name, type.to_ast]
        ast << false unless required?
        ast
      end

    end # module BuiltinType
  end # module Syntax
end # module Finitio
