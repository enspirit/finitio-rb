module Qrb
  module Syntax
    module NamedConstraint

      def compile(var_name)
        { constraint_name.to_sym => expression.compile(var_name) }
      end

    end # module NamedConstraint
  end # module Syntax
end # module Qrb
