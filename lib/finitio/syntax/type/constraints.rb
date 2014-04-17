module Finitio
  module Syntax
    module Constraints
      include Node

      def compile(var_name)
        cs = captures[:constraint].map{|c| c.compile(var_name) }
        unique_names!(cs, 'constraint')
      end

      def to_ast(var_name)
        captures[:constraint].map{|c| c.to_ast(var_name) }
      end

    end # module Constraints
  end # module Syntax
end # module Finitio
