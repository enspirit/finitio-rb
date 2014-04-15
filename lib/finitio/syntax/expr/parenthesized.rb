module Finitio
  module Syntax
    module Expr
      module Parenthesized
        include Expr

        capture :expr

        def to_proc_source(varnames)
          expr.to_proc_source(varnames)
        end

      end # module Parenthesized
    end # module Expr
  end # module Syntax
end # module Finitio
