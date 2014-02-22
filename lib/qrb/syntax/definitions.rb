module Qrb
  module Syntax
    module Definitions

      def compile(realm)
        captures[:type_def].each do |node|
          node.compile(realm)
        end
        realm
      end

    end # module Definitions
  end # module Syntax
end # module Qrb
