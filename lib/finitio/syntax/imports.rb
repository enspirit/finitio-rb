module Finitio
  module Syntax
    module Imports
      include Node

      def compile(system)
        captures[:import].each do |node|
          node.compile(system)
        end
        system
      end

      def to_ast
        [:imports] + captures[:import].map(&:to_ast)
      end

    end # module Imports
  end # module Syntax
end # module Finitio
