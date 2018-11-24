require 'citrus'
require_relative 'syntax/node'
require_relative 'syntax/literal'
require_relative 'syntax/expr'
require_relative 'syntax/type'
require_relative 'syntax/import'
require_relative 'syntax/imports'
require_relative 'syntax/definitions'
require_relative 'syntax/system'
module Finitio
  module Syntax

    Citrus.load File.expand_path('../syntax/lexer.citrus', __FILE__)
    Citrus.load File.expand_path('../syntax/literals.citrus', __FILE__)
    Citrus.load File.expand_path('../syntax/expressions.citrus', __FILE__)
    Citrus.load File.expand_path('../syntax/finitio.citrus', __FILE__)

    def self.parse(source, *args, &bl)
      source = File.read(source) if source.respond_to?(:to_path)
      Parser.parse(source, *args, &bl)
    end

    def self.ast(source)
      parse(source, root: "system").to_ast
    end

    def self.compile(source, cpl = nil)
      cpl = Compilation.coerce(cpl, source)
      parse(source, root: "system").compile(cpl)
      cpl.resolve_proxies!.system
    end

    def self.compile_type(source, cpl = nil)
      cpl = Compilation.coerce(cpl, source)
      parse(source, root: "type").compile(cpl)
    end

  end # module Syntax
end # module Finitio
