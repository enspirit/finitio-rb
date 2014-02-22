require 'citrus'
require 'sexpr'
module Qrb
  Syntax = Sexpr.load File.expand_path('../syntax/q.sexp.yml', __FILE__)
  module Syntax

    def self.compile_realm(source)
      parse(source, root: "realm_def").compile(Realm.new)
    end

    def self.compile_type(str)
      parse(str.strip, root: "type").compile(TypeFactory.new)
    end

  end
end
require_relative 'syntax/support'
require_relative 'syntax/expression'
require_relative 'syntax/attribute'
require_relative 'syntax/heading'
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
require_relative 'syntax/type_def'
require_relative 'syntax/realm_def'
require_relative 'syntax/type_ref'
require_relative 'syntax/ad_type'
require_relative 'syntax/contract'
