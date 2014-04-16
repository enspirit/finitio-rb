module Finitio
  module Syntax
    module TypeDef
      include Node

      capture :type
      capture_str :type_name

      def compile(system)
        t = type.compile(system)
        if t.anonymous?
          t.name = type_name
          system.add_type(t)
        else
          system.add_type(AliasType.new(t, type_name))
        end
        t
      end

      def to_ast
        [:type_def, type_name, type.to_ast]
      end

    end # module TypeDef
  end # module Syntax
end # module Finitio
