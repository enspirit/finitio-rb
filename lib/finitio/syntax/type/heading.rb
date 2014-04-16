module Finitio
  module Syntax
    module Heading
      include Node

      capture :allow_extra

      def allow_extra?
        !allow_extra.nil?
      end

      def multi?
        captures[:attribute].any?{|a| a.optional? } or allow_extra?
      end

      def attributes(factory)
        captures[:attribute].map{|a| a.compile(factory) }
      end

      def compile(factory)
        Finitio::Heading.new(attributes(factory), allow_extra: allow_extra?)
      end

      def to_ast
        captures[:attribute].map(&:to_ast).unshift(:heading)
      end

    end # module Heading
  end # module Syntax
end # module Finitio
