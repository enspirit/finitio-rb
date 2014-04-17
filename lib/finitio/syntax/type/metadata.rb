module Finitio
  module Syntax
    module Metadata
      include Node

      capture :description

      def value
        if description
          { description: description.to_str.strip }
        else
          Hash[captures[:metadata_attr].map(&:value)]
        end
      end

    end # module Metadata
  end # module Syntax
end # module Metadata
