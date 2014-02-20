require "qrb/version"
require "qrb/loader"
require "qrb/errors"

#
# Q - in Ruby
#
module Qrb

end # module Qrb
require_relative 'qrb/attribute'
require_relative 'qrb/heading'
require_relative 'qrb/type'
require_relative 'qrb/builtin_type'
require_relative 'qrb/union_type'
require_relative 'qrb/sub_type'
require_relative 'qrb/tuple_type'
require_relative 'qrb/relation_type'
