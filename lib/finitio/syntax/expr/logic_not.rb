module Finitio
  module Syntax
    module Expr
      module LogicNot
        include Expr

        capture :term

        def to_proc_source(varnames)
          l = term.to_proc_source(varnames)
          "!(#{l})"
        end

      end # module LogicNot
    end # module Expr
  end # module Syntax
end # module Finitio
