module Finitio
  module Syntax
    module System
      extend AstNode

      capture :definitions, :type

      def compile(system)
        definitions.compile(system)
        if type
          system.main = type.compile(system)
        end
        system
      end

      def to_ast
        ast = [ :system ] + definitions.to_ast
        ast << type.to_ast if type
        ast
      end

    end # module System
  end # module Syntax
end # module Finitio
