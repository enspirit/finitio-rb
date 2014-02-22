module Qrb
  module Syntax
    module RealmDef

      def compile(factory)
        captures[:statement].each do |node|
          node.compile(factory)
        end
        factory
      end

    end # module RealmDef
  end # module Syntax
end # module Qrb
