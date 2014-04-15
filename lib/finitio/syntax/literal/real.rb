module Finitio
  module Syntax
    module Literal
      module Real
        include Literal

        def value
          ::Kernel.Float(to_str)
        end

      end # module Real
    end # module Literal
  end # module Syntax
end # module Finitio
