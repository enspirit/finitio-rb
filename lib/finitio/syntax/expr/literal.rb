module Finitio
  module Syntax
    module Expr
      module Literal
        include Expr

        capture :literal

        def to_proc_source
          literal.to_ruby
        end

        def _free_variables(fvs)
        end

      end # module Identifier
    end # module Expr
  end # module Syntax
end # module Finitio
