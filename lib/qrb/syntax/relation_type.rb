module Qrb
  module Syntax
    module RelationType

      def compile(factory)
        factory.relation(heading.compile(factory))
      end

    end # module RelationType
  end # module Syntax
end # module Qrb
