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
require_relative 'syntax/inline_pair'
require_relative 'syntax/external_pair'
require_relative 'syntax/lambda_expr'
module Finitio
  module Syntax

    Citrus.load File.expand_path('../syntax/finitio.citrus', __FILE__)

    def self.parse(source, *args, &bl)
      source = File.read(source) if source.respond_to?(:to_path)
      Parser.parse(source, *args, &bl)
    end

    def self.ast(source)
      parse(source, root: "system").to_ast
    end

    def self.compile(source, cpl = nil)
      cpl = Compilation.coerce(cpl)
      parse(source, root: "system").compile(cpl)
      cpl.resolve_proxies!.system
    end

    def self.compile_type(source, cpl = nil)
      cpl = Compilation.coerce(cpl)
      parse(source, root: "type").compile(cpl)
    end

  end
end
