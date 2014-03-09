module Qrb
  module Syntax
    module InlinePair
      include Support

      def compile(factory)
        [ dress.compile(factory), undress.compile(factory) ]
      end

    end # module InlinePair
  end # module Syntax
end # module Qrb
