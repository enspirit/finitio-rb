module Finitio
  module Syntax
    module Contract
      include Node

      capture :type, :pair
      capture_str :contract_name

      def compile(factory, clazz)
        name = contract_name.to_sym
        infotype = type.compile(factory)
        dresser, undresser  = compile_pair(factory, clazz)
        factory.contract(infotype, dresser, undresser, name, metadata)
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
          contract_name,
          (type && type.to_ast) 
        ]
        ast << pair.to_ast if pair
        ast
      end

    end # module Contract
  end # module Syntax
end # module Finitio
