module Finitio
  module Syntax
    module Literal
      include Node

      def to_ruby
        to_str.strip
      end

    end # module Literal
  end # module Syntax
end # module Finitio
require_relative 'literal/boolean'
require_relative 'literal/integer'
require_relative 'literal/real'
require_relative 'literal/string'
