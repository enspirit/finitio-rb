require 'citrus'
require 'sexpr'
module Qrb
  Syntax = Sexpr.load File.expand_path('../syntax/q.sexp.yml', __FILE__)
  module Syntax

    def self.compile(str)
      parse(str.strip).compile(RealmBuilder.new)
    end

  end
end
require_relative 'syntax/attribute'
require_relative 'syntax/heading'
require_relative 'syntax/builtin_type'
require_relative 'syntax/sub_type'
require_relative 'syntax/constraint_def'
require_relative 'syntax/seq_type'
require_relative 'syntax/set_type'
require_relative 'syntax/tuple_type'
require_relative 'syntax/relation_type'
require_relative 'syntax/union_type'
