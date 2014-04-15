module Finitio
  module Syntax
    module Literal
      module Integer
        include Literal

        def value
          ::Kernel.Integer(to_str)
        end

      end # module Integer
    end # module Literal
  end # module Syntax
end # module Finitio
