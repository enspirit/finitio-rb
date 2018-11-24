module Finitio
  module Syntax
    module System
      include Node

      capture :imports, :definitions, :main_type

      def compile(system)
        imports.compile(system) if imports
        definitions.compile(system)
        main_type.compile(system) if main_type
        system
      end

      def to_ast
        ast = [ :system ]
        imports_ast = imports.to_ast
        ast << imports_ast unless imports_ast.size == 1
        ast += definitions.to_ast
        ast << main_type.to_ast if main_type
        ast
      end

    end # module System
  end # module Syntax
end # module Finitio
