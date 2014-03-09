module Qrb
  module Syntax
    module Heading

      def attributes(factory)
        captures[:attribute].map{|x| x.compile(factory) }
      end

      def compile(factory)
        Qrb::Heading.new(attributes(factory))
      end

      def to_ast
        captures[:attribute].map(&:to_ast).unshift(:heading)
      end

    end # module Heading
  end # module Syntax
end # module Qrb
