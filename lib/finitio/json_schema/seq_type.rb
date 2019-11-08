module Finitio
  class SeqType

    def to_json_schema(*args, &bl)
      {
        type: "array",
        items: elm_type.to_json_schema(*args, &bl)
      }
    end

  end # class SeqType
end # module Finitio
