module Finitio
  module Syntax
    module AdType
      include Node

      capture :builtin_type_name

      def compile(factory)
        name      = builtin_type_name
        clazz     = name ? resolve_ruby_const(name.to_s) : nil
        contracts = compile_contracts(factory, clazz)
        contracts = unique_names!(contracts, "contract")
        factory.adt(clazz, contracts)
      end

      def compile_contracts(factory, clazz)
        captures[:contract].map{|c| c.compile(factory, clazz) }
      end

      def to_ast
        [ 
          :ad_type,
          builtin_type_name ? builtin_type_name.to_s : nil
        ] + captures[:contract].map(&:to_ast)
      end

    end # module AdType
  end # module Syntax
end # module Finitio
