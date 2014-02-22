module Qrb
  module Syntax
    module Constraints

      def compile(var_name)
        constraints = {}
        captures[:named_constraint].each do |node|
          compiled = node.compile(var_name)
          constraints.merge!(compiled) do |k,_,_|
            raise Error, "Duplicate constraint name `#{k}`"
          end
        end
        constraints
      end

    end # module Constraints
  end # module Syntax
end # module Qrb
