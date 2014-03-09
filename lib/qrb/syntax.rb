require 'citrus'
require_relative 'syntax/support'
require_relative 'syntax/system'
require_relative 'syntax/definitions'
require_relative 'syntax/type_def'
require_relative 'syntax/expression'
require_relative 'syntax/attribute'
require_relative 'syntax/heading'
require_relative 'syntax/any_type'
require_relative 'syntax/builtin_type'
require_relative 'syntax/sub_type'
require_relative 'syntax/constraint_def'
require_relative 'syntax/constraints'
require_relative 'syntax/named_constraint'
require_relative 'syntax/unnamed_constraint'
require_relative 'syntax/seq_type'
require_relative 'syntax/set_type'
require_relative 'syntax/tuple_type'
require_relative 'syntax/relation_type'
require_relative 'syntax/union_type'
require_relative 'syntax/type_ref'
require_relative 'syntax/ad_type'
require_relative 'syntax/contract'
require_relative 'syntax/lambda_expr'
module Qrb
  module Syntax

    Citrus.load File.expand_path('../syntax/q.citrus', __FILE__)

    def self.parse(*args, &bl)
      Parser.parse(*args, &bl)
    end

    def self.compile(source, system = Qrb::System.new)
      Parser.parse(source, root: "system").compile(system)
    end

    def self.compile_type(str)
      Parser.parse(str.strip, root: "type").compile(TypeFactory.new)
    end

  end
end
