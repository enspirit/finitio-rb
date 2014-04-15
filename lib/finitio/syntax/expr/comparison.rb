module Finitio
  module Syntax
    module Expr
      module Comparison
        include Expr

        capture :left, :op, :right

        def to_proc_source(varnames)
          l, r = left.to_proc_source(varnames), right.to_proc_source(varnames)
          "#{l}.#{op.to_str.strip}(#{r})"
        end

      end # module Comparison
    end # module Expr
  end # module Syntax
end # module Finitio
