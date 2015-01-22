module Finitio
  module Syntax
    module Expr
      module OOCall
        include Expr

        capture :left, :right

        def to_proc_source
          l, r = left.to_proc_source, right.to_proc_source
          "#{l}.fetch(#{r})"
        end

        def _free_variables(fvs)
          left._free_variables(fvs)
        end

      end # module OOCall
    end # module Expr
  end # module Syntax
end # module Finitio
