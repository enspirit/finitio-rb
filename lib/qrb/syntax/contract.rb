module Qrb
  module Syntax
    module Contract

      def compile(factory, clazz)
        contract = [ type.compile(factory) ] + compile_pair(factory, clazz)
        { contract_name.to_sym => contract }
      end

      def compile_pair(factory, clazz)
        if pair
          pair.compile(factory)
        elsif clazz
          dresser   = clazz.method(contract_name.to_sym)
          undresser = clazz.instance_method(:"to_#{contract_name}")
          [
            dresser,
            ->(d){ undresser.bind(d).call }
          ]
        else
          [ Qrb::IDENTITY, Qrb::IDENTITY ]
        end
      end

    end # module Contract
  end # module Syntax
end # module Qrb
