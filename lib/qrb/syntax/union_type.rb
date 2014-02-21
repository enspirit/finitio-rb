module Qrb
  module Syntax
    module UnionType

      def compile(builder)
        cds = captures[:sub_type].map{|x| x.compile(builder) }
        builder.union(cds)
      end

    end # module UnionType
  end # module Syntax
end # module Qrb
