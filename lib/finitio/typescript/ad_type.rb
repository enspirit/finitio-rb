module Finitio
  class AdType

    def to_typescript(*args, &bl)
      contracts.map{|c| c.infotype.ts_name || c.infotype.to_typescript(*args, &bl) }.join('|')
    end

  end # class AdType
end # module Finitio
