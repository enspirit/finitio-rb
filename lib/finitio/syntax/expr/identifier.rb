module Finitio
  module Syntax
    module Expr
      module Identifier
        include Expr

        def to_proc_source(free = true)
          self.to_str
        end

        def _free_variables(fvs)
          fvs << self.to_str
        end

      end # module Identifier
    end # module Expr
  end # module Syntax
end # module Finitio
