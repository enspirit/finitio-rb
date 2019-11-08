module Finitio
  class SubType

    def to_json_schema(*args, &bl)
      # TODO: add support for constraints here...
      super_type.to_json_schema(*args, &bl)
    end

  end # class SubType
end # module Finitio
