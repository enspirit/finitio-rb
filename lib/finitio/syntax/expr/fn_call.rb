module Finitio
  module Syntax
    module Expr
      module FnCall
        include Expr

        capture :fn

        def to_proc_source(varnames)
          args = captures[:expr].map{|t| t.to_proc_source(varnames) }
          first, rest = args.first, args[1..-1]
          "#{first}.#{fn}(#{rest.join(',')})"
        end

      end # module FnCall
    end # module Expr
  end # module Syntax
end # module Finitio
