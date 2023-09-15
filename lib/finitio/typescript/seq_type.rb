module Finitio
  class SeqType

    def to_typescript(*args, &bl)
      type_ts = elm_type.ts_name || elm_type.to_typescript(*args, &bl)
      "Array<#{type_ts}>"
    end

  end # class SeqType
end # module Finitio
