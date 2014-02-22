module Qrb
  module Syntax
    module UnnamedConstraint

      def compile(var_name)
        { predicate: expression.compile(var_name) }
      end

    end # module UnnamedConstraint
  end # module Syntax
end # module Qrb
