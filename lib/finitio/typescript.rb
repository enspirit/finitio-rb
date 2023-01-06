module Finitio
  module Typescript
    class Error < Finitio::Error; end
  end # module Typescript
end # module Finitio
require_relative 'typescript/type'
require_relative 'typescript/ad_type'
require_relative 'typescript/any_type'
require_relative 'typescript/alias_type'
require_relative 'typescript/builtin_type'
require_relative 'typescript/hash_based_type'
require_relative 'typescript/high_order_type'
require_relative 'typescript/rel_based_type'
require_relative 'typescript/seq_type'
require_relative 'typescript/set_type'
require_relative 'typescript/struct_type'
require_relative 'typescript/sub_type'
require_relative 'typescript/union_type'
require_relative 'typescript/proxy_type'
require_relative 'typescript/system'
