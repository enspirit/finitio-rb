module Qrb
  module Syntax
    module UnionType

      def compile(factory)
        cds = captures[:sub_type].map{|x| x.compile(factory) }
        factory.union(cds)
      end

    end # module UnionType
  end # module Syntax
end # module Qrb
