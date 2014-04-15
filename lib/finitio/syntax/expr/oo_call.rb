module Finitio
  module Syntax
    module Expr
      module OOCall
        include Expr

        capture :left, :right

        def to_proc_source(varnames)
          l, r = left.to_proc_source(varnames), right.to_proc_source(varnames)
          "#{l}.#{r}"
        end

      end # module OOCall
    end # module Expr
  end # module Syntax
end # module Finitio
