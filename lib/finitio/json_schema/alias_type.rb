module Finitio
  class AliasType

    def to_json_schema(*args, &bl)
      target.to_json_schema(*args, &bl)
    end

  end # class AliasType
end # module Finitio
