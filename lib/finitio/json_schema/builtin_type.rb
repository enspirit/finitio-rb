module Finitio
  module JsonSchema

    BUILTIN_MAPPING = {
      NilClass => "string", # jsonapi does not support null
      String => "string",
      Integer => "integer",
      Float => "number",
      Numeric => "number",
      TrueClass => "boolean",
      FalseClass => "boolean",
      Hash => "object",
      Object => "object"
    }

  end
  class BuiltinType

    def to_json_schema(*args, &bl)
      if type = metadata[:jsonSchemaType]
        return { type: type }
      end

      mapped = JsonSchema::BUILTIN_MAPPING[ruby_type]
      if mapped
        { type: mapped }
      else
        raise JsonSchema::Error, "Unable to map #{ruby_type} to json-schema"
      end
    end

  end # class BuiltinType
end # module Finitio
