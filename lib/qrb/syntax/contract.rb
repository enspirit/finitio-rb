module Qrb
  module Syntax
    module Contract

      def compile(factory, clazz)
        contract = [
          type.compile(factory),
          compile_upper(factory, clazz)
        ]
        { contract_name.to_sym => contract }
      end

      def compile_upper(factory, clazz)
        if up
          up.compile(factory)
        elsif clazz
          clazz.method(contract_name.to_sym)
        else
          Qrb::IDENTITY
        end
      end

    end # module Contract
  end # module Syntax
end # module Qrb
