module Finitio
  class UnionType

    def to_json_schema(*args, &bl)
      {
        anyOf: candidates.map{|c| c.to_json_schema(*args, &bl) }
      }
    end

  end # class UnionType
end # module Finitio
