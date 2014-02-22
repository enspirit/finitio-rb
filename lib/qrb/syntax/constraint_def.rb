module Qrb
  module Syntax
    module ConstraintDef

      def compile(factory)
        constraints.compile(var_name)
      end

    end # module ConstraintDef
  end # module Syntax
end # module Qrb
