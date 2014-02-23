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
          contract = node.compile(factory, clazz)
          contracts.merge!(contract) do |k,_,_|
            raise Error, "Duplicate contract name `#{k}`"
          end
        end
        contracts
      end

    end # module AdType
  end # module Syntax
end # module Qrb
