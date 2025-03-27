module Finitio
  class StructType

    def to_json_schema(*args, &bl)
      if type = metadata[:jsonSchemaType]
        return { type: type }
      end

      {
        type: "array",
        items: component_types.map{|c| c.to_json_schema(*args, &bl) }
      }
    end

  end # class StructType
end # module Finitio
