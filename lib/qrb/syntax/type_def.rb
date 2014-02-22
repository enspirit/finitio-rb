module Qrb
  module Syntax
    module TypeDef

      def compile(realm)
        t = type.compile(realm)
        t.name = type_name.to_s
        realm.add_type(t)
        t
      end

    end # module TypeDef
  end # module Syntax
end # module Qrb
