module Finitio
  module Syntax
    module Expr
      module LogicDyadic
        include Expr

        capture :left, :op, :right

        def to_proc_source(varnames)
          l, r = left.to_proc_source(varnames), right.to_proc_source(varnames)
          "(#{l} #{op} #{r})"
        end

      end # module LogicDyadic
    end # module Expr
  end # module Syntax
end # module Finitio
