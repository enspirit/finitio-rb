module Finitio
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
          [ Finitio::IDENTITY, Finitio::IDENTITY ]
        end
      end

      def to_ast
        ast = [
          :contract,
          contract_name.to_s,
          (type && type.to_ast) 
        ]
        ast << pair.to_ast if pair
        ast
      end

    end # module Contract
  end # module Syntax
end # module Finitio
