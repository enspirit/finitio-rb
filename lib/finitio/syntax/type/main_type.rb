module Finitio
  module Syntax
    module MainType
      include Node

      capture :type

      def compile(system)
        type.compile(system)
      end

      def to_ast
        type.to_ast
      end

    end # module MainType
  end # module Syntax
end # module Finitio
