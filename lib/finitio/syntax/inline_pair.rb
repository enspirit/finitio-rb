module Finitio
  module Syntax
    module InlinePair
      include Support

      def compile(factory)
        [ dress.compile(factory), undress.compile(factory) ]
      end

      def to_ast
        [ :inline_pair, dress.to_ast, undress.to_ast ]
      end

    end # module InlinePair
  end # module Syntax
end # module Finitio
