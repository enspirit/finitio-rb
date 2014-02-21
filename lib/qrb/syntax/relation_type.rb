module Qrb
  module Syntax
    module RelationType

      def compile(builder)
        builder.relation(heading.compile(builder))
      end

    end # module RelationType
  end # module Syntax
end # module Qrb
