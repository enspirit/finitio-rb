module Finitio
  module Syntax
    module Expr
      module UnaryMinusOp
        include Expr

        capture :term

        def to_proc_source
          r = term.to_proc_source
          "-#{r}"
        end

        def _free_variables(fvs)
          term._free_variables(fvs)
        end

      end # module UnaryMinusOp
    end # module Expr
  end # module Syntax
end # module Finitio
