module Finitio
  module Syntax
    module Expr
      module FnCall
        include Expr

        capture :fn

        def to_proc_source
          args = captures[:expr].map(&:to_proc_source)
          first, rest = args.first, args[1..-1]
          "#{first}.#{fn}(#{rest.join(',')})"
        end

        def _free_variables(fvs)
          captures[:expr].each do |e|
            e._free_variables(fvs)
          end
        end

      end # module FnCall
    end # module Expr
  end # module Syntax
end # module Finitio
