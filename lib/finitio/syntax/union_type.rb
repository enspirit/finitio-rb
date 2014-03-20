module Finitio
  module Syntax
    module UnionType

      def compile(factory)
        cds = captures[:sub_type].map{|x| x.compile(factory) }
        factory.union(cds)
      end

      def to_ast
        captures[:sub_type].map(&:to_ast).unshift(:union_type)
      end

    end # module UnionType
  end # module Syntax
end # module Finitio
