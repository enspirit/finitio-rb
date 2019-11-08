module Finitio
  class AdType

    def to_json_schema(*args, &bl)
      {
        anyOf: contracts.map{|c| c.infotype.to_json_schema(*args, &bl) }
      }
    end

  end # class AdType
end # module Finitio
