module Qrb
  module Syntax
    module Definitions

      def compile(system)
        captures[:type_def].each do |node|
          node.compile(system)
        end
        system
      end

    end # module Definitions
  end # module Syntax
end # module Qrb
