module Finitio
  module Syntax
    module System
      include Node

      capture :definitions, :main_type

      def compile(system)
        definitions.compile(system)
        main_type.compile(system) if main_type
        system
      end

      def to_ast
        ast = [ :system ] + definitions.to_ast
        ast << main_type.to_ast if main_type
        ast
      end

    end # module System
  end # module Syntax
end # module Finitio
