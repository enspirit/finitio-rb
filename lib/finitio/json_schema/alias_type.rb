module Finitio
  class AliasType

    def to_json_schema(*args, &bl)
      if type = metadata[:jsonSchemaType]
        return { type: type }
      end

      target.to_json_schema(*args, &bl)
    end

  end # class AliasType
end # module Finitio
