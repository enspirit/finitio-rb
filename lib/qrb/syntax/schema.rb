module Qrb
  module Syntax
    module Schema

      def compile(realm)
        definitions.compile(realm)
        type.compile(realm)
      end

    end # module Schema
  end # module Syntax
end # module Qrb
