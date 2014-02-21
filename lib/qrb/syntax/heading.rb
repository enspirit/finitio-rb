module Qrb
  module Syntax
    module Heading

      def attributes(builder)
        captures[:attribute].map{|x| x.compile(builder) }
      end

      def compile(builder)
        Qrb::Heading.new(attributes(builder))
      end

    end # module Heading
  end # module Syntax
end # module Qrb
