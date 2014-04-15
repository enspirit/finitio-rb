module Finitio
  module Syntax
    module Expr
      module UnaryMinusOp
        include Expr

        capture :term

        def to_proc_source(varnames)
          r = term.to_proc_source(varnames)
          "-#{r}"
        end

      end # module UnaryMinusOp
    end # module Expr
  end # module Syntax
end # module Finitio
