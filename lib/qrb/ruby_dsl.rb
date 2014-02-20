module Qrb
  module RubyDSL

    def builtin(ruby_type, name = nil)
      BuiltinType.new(ruby_type, name)
    end

    def sub_type(super_type, constraint, name = nil)
      constraint = { predicate: constraint } unless constraint.is_a?(Hash)
      SubType.new(super_type, constraint, name)
    end

    def tuple_type(defn, name = nil)
      TupleType.new(heading(defn), name)
    end

    def relation_type(defn, name = nil)
      RelationType.new(heading(defn), name)
    end

    def union_type(*candidates)
      UnionType.new(candidates)
    end

  private

    def heading(h)
      return h if h.is_a?(Heading)
      return h.heading if h.respond_to?(:heading)
      Heading.new(h.map{|k,v| Attribute.new(k, v)})
    end

  end # module RubyDSL
end # module Qrb
