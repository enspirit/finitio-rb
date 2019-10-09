module Finitio
  module Support

    def compare_attrs(h1, h2, &bl)
      mine, yours = if bl
        [h1.map(&bl), h2.map(&bl)]
      elsif h1.is_a?(Hash)
        [h1.keys, h2.keys]
      else
        [h1, h2]
      end
      [ mine & yours, mine - yours, yours - mine ]
    end
    module_function :compare_attrs

  end # module Support
end # module Finitio
require_relative 'support/proc_with_code'
require_relative 'support/metadata'
require_relative 'support/attribute'
require_relative 'support/constraint'
require_relative 'support/contract'
require_relative 'support/heading'
require_relative 'support/dress_helper'
require_relative 'support/type_factory'
require_relative 'support/fetch_scope'
require_relative 'support/compilation'
