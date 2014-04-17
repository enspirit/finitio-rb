module Finitio
  module Syntax
    module MetadataAttr
      include Node

      capture_str :attribute_name
      capture :literal

      def value
        [ attribute_name.to_sym, literal.value ]
      end

    end # module MetadataAttr
  end # module Syntax
end # module Metadata
