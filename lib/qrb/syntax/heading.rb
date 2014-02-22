module Qrb
  module Syntax
    module Heading

      def attributes(factory)
        captures[:attribute].map{|x| x.compile(factory) }
      end

      def compile(factory)
        Qrb::Heading.new(attributes(factory))
      end

    end # module Heading
  end # module Syntax
end # module Qrb
