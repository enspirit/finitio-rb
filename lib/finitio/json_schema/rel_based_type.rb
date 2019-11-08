module Finitio
  module RelBasedType

    def to_json_schema(*args, &bl)
      {
        type: "array",
        items: tuple_type.to_json_schema(*args, &bl),
        uniqueItems: true
      }
    end

  end # module RelBasedType
end # module Finitio
