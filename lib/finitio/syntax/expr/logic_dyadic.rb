module Finitio
  module Syntax
    module Expr
      module LogicDyadic
        include Expr

        capture :left, :op, :right

        def to_proc_source
          l, r = left.to_proc_source, right.to_proc_source
          "(#{l} #{op} #{r})"
        end

        def _free_variables(fvs)
          left._free_variables(fvs)
          right._free_variables(fvs)
        end

      end # module LogicDyadic
    end # module Expr
  end # module Syntax
end # module Finitio
