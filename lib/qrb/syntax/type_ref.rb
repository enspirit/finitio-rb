module Qrb
  module Syntax
    module TypeRef

      def compile(factory)
        factory.fetch(type_name.to_s) do |n|
          raise Error, "Unknown type `#{n}`"
        end
      end

    end # module TypeRef
  end # module Syntax
end # module Qrb
