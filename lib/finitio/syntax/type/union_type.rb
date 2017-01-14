module Finitio
  module Syntax
    module UnionType
      include Node

      def compile(factory)
        cds = captures[:sub_type].map{|x| x.compile(factory) }
        cds.size == 1 ? cds.first : factory.union(cds)
      end

      def to_ast
        cds = captures[:sub_type].map(&:to_ast)
        cds.size == 1 ? cds.first : cds.unshift(:union_type)
      end

    end # module UnionType
  end # module Syntax
end # module Finitio
