module Finitio
  module Syntax
    module Expr
      module Literal
        include Expr

        capture :literal

        def to_proc_source(varnames)
          literal.to_ruby
        end

      end # module Identifier
    end # module Expr
  end # module Syntax
end # module Finitio
