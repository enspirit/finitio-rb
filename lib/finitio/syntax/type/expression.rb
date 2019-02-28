module Finitio
  module Syntax
    module Expression
      include Node

      def compile(var_name)
        ProcWithCode.new(var_name, to_str)
      end

    end # module Expression
  end # module Syntax
end # module Finitio
