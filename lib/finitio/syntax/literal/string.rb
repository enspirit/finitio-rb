module Finitio
  module Syntax
    module Literal
      module String
        include Literal

        def value
          to_str[1...-1].gsub(/\\"/, '"')
        end

      end # module String
    end # module Literal
  end # module Syntax
end # module Finitio
