module Finitio
  module Syntax
    module Literal
      module Boolean
        include Literal

        TRUE  = "true".freeze
        FALSE = "false".freeze

        def value
          case to_str.strip
          when TRUE  then true
          when FALSE then false
          else
            raise "Unexpected boolean literal `#{to_str}`"
          end
        end

      end # module Boolean
    end # module Literal
  end # module Syntax
end # module Finitio
