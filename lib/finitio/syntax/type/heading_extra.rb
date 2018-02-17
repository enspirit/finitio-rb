module Finitio
  module Syntax
    module HeadingExtra
      include Node

      capture :extra_type

      def compile(factory)
        { allow_extra: extra_type ? extra_type.compile(factory) : true }
      end

      def to_ast
        { allow_extra: extra_type ? extra_type.to_ast : true }
      end

    end # module HeadingExtra
  end # module Syntax
end # module Finitio
