module Qrb
  module Syntax
    module AdType
      include Support

      def compile(factory)
        name  = builtin_type_name
        clazz = name ? resolve_ruby_const(name.to_s) : nil
        factory.adt(clazz, compile_contracts(factory, clazz))
      end

      def compile_contracts(factory, clazz)
        contracts = {}
        captures[:contract].each do |node|
          compile_contract(factory, clazz, contracts, node)
        end
        contracts
      end

      def compile_contract(factory, clazz, contracts, node)
        name, infotype = node.compile(factory)
        if contracts[name]
          raise Error, "Duplicate contract name `#{name}`"
        end
        contract = if clazz
          [ infotype, clazz.method(name) ]
        else
          [ infotype, IDENTITY ]
        end
        contracts[name] = contract
      end

    end # module AdType
  end # module Syntax
end # module Qrb
