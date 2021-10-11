module Finitio
  module JsonSchema
    class Error < Finitio::Error; end
  end # module JsonSchema
end # module Finitio
require_relative 'json_schema/ad_type'
require_relative 'json_schema/any_type'
require_relative 'json_schema/alias_type'
require_relative 'json_schema/builtin_type'
require_relative 'json_schema/hash_based_type'
require_relative 'json_schema/rel_based_type'
require_relative 'json_schema/seq_type'
require_relative 'json_schema/set_type'
require_relative 'json_schema/struct_type'
require_relative 'json_schema/sub_type'
require_relative 'json_schema/union_type'
require_relative 'json_schema/proxy_type'
