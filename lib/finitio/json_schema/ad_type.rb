module Finitio
  class AdType

    def to_json_schema(*args, &bl)
      if type = metadata[:jsonSchemaType]
        return { type: type }
      end

      subtypes = contracts
          .map{|c| c.infotype.to_json_schema(*args, &bl) }
          .uniq
      subtypes.size == 1 ? subtypes.first : { anyOf: subtypes }
    end

  end # class AdType
end # module Finitio
