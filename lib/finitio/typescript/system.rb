module Finitio
  class System
    def to_typescript(*args, &bl)
      ts = types.map do |name, t|
        "export type #{t.ts_name} = #{t.to_typescript(*args, &bl)}"
      end
      ts.join("\n")
    end
  end # class AdType
end # module Finitio
