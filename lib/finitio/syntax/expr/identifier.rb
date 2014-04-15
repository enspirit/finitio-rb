module Finitio
  module Syntax
    module Expr
      module Identifier
        include Expr

        def to_proc_source(varnames)
          unless varnames.map(&:to_s).include?(self.to_s)
            raise Error, "No such variable `#{to_str}`"
          end
          self.to_str
        end

      end # module Identifier
    end # module Expr
  end # module Syntax
end # module Finitio
