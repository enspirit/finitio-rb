module Qrb
  module Syntax
    module ConstraintDef

      def compile(factory)
        constraints.compile(var_name.to_s)
      end

    end # module ConstraintDef
  end # module Syntax
end # module Qrb
