module Finitio
  module Syntax
    module Expr
      module OOCall
        include Expr

        capture :left

        def to_proc_source
          l = left.to_proc_source
          r = captures[:right]
          .map{|s| "fetch(:#{s.to_proc_source})" }
          .join('.')
          "#{l}.#{r}"
        end

        def _free_variables(fvs)
          left._free_variables(fvs)
        end

      end # module OOCall
    end # module Expr
  end # module Syntax
end # module Finitio
