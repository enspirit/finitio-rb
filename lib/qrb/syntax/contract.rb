module Qrb
  module Syntax
    module Contract

      def compile(factory)
        [ contract_name.to_sym, type.compile(factory) ]
      end

    end # module Contract
  end # module Syntax
end # module Qrb
