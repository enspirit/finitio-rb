module Finitio
  module Syntax
    module TypeRef

      def compile(factory)
        factory.fetch(type_name.to_s) do |n|
          factory.proxy(n)
        end
      end

      def to_ast
        [:type_ref, type_name.to_s]
      end

    end # module TypeRef
  end # module Syntax
end # module Finitio
