module Finitio
  module Syntax
    module Expr
      module Parenthesized
        include Expr

        capture :expr

        def to_proc_source
          expr.to_proc_source
        end

        def _free_variables(fvs)
          expr._free_variables(fvs)
        end

      end # module Parenthesized
    end # module Expr
  end # module Syntax
end # module Finitio
