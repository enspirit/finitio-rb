module Qrb
  module Syntax
    module TypeDef

      def compile(system)
        t = type.compile(system)
        t.name = type_name.to_s
        system.add_type(t)
        t
      end

      def to_ast
        [:type_def, type_name.to_s, type.to_ast]
      end

    end # module TypeDef
  end # module Syntax
end # module Qrb
