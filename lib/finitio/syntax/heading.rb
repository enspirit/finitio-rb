module Finitio
  module Syntax
    module Heading

      def multi?
        captures[:attribute].any?{|a| a.optional? }
      end

      def attributes(factory)
        captures[:attribute].map{|a| a.compile(factory) }
      end

      def compile(factory)
        Finitio::Heading.new(attributes(factory))
      end

      def to_ast
        captures[:attribute].map(&:to_ast).unshift(:heading)
      end

    end # module Heading
  end # module Syntax
end # module Finitio
