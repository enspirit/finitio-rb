module Finitio
  class SetType

    def to_json_schema(*args, &bl)
      {
        type: "array",
        items: elm_type.to_json_schema(*args, &bl),
        uniqueItems: true
      }
    end

  end # class SetType
end # module Finitio
