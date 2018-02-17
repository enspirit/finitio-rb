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
        options = allow_extra ? allow_extra.compile(factory) : {}
        Finitio::Heading.new(attributes(factory), options)
      end

      def to_ast
        ast = captures[:attribute].map(&:to_ast).unshift(:heading)
        ast << allow_extra.to_ast if allow_extra
        ast
      end

    end # module Heading
  end # module Syntax
end # module Finitio
