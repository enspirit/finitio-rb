module Finitio
  module Syntax
    module Expr
      module LogicNot
        include Expr

        capture :term

        def to_proc_source
          l = term.to_proc_source
          "!(#{l})"
        end

        def _free_variables(fvs)
          term._free_variables(fvs)
        end

      end # module LogicNot
    end # module Expr
  end # module Syntax
end # module Finitio
