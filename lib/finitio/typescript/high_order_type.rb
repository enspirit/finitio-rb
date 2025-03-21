module Finitio
  class HighOrderType < Type
    def to_typescript(*args, &bl)
      defn.ts_name || defn.to_typescript(*args, &bl)
    end

    def ts_name
      "#{super}<#{vars.join(', ')}>" if super
    end
  end # class HighOrderType
end # module Finitio
