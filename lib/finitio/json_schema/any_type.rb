module Finitio
  class AnyType

    def to_json_schema(*args, &bl)
      if type = metadata[:jsonSchemaType]
        return { type: type }
      end

      {}
    end

  end # class AnyType
end # module Finitio
