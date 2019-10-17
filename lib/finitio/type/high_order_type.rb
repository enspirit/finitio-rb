module Finitio
  class HighOrderType < Type

    def initialize(vars, defn, name = nil, metadata = nil)
      super(name, metadata)
      @vars = vars
      @defn = defn
    end
    attr_reader :vars, :defn

    def default_name
      "Type<#{vars.join(',')}>"
    end

    def suppremum(other)
      raise NotImplementedError, "Suppremum is not defined on high order types"
    end

    def ==(other)
      super || other.is_a?(HighOrderType) \
            && other.vars == self.vars \
            && other.defn = self.defn
    end

    def resolve_proxies(system)
      self
    end

    def instantiate(compilation, sub_types)
      overrides = Hash[vars.zip(sub_types)]
      defn.resolve_proxies(compilation.with_scope(overrides))
    end

    def unconstrained
      HighOrderType.new(vars, defn.unconstrained, name, metadata)
    end

  end # class HighOrderType
end # module Finitio
