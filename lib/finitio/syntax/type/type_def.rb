module Finitio
  module Syntax
    module TypeDef
      include Node

      capture :type
      capture :type_name
      capture :vars

      def compile(system)
        if vars
          vs = vars.compile(system)
          overrides = Hash[vs.map{|v|
            [ v.to_s, ProxyType.new(v) ]
          }]
          t = type.compile(system.with_scope(overrides))
          t = HighOrderType.new(vs, t)
        else
          t = type.compile(system)
        end
        n = type_name && type_name.to_str
        m = metadata
        system.add_type(t, n, m)
        t
      end

      def to_ast
        [:type_def, type_name, type.to_ast]
      end

    end # module TypeDef
  end # module Syntax
end # module Finitio
