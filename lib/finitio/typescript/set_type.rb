module Finitio
  class SetType

    def to_typescript(*args, &bl)
      type = elm_type.to_typescript(*args, &bl)
      "Set<#{type}>"
    end

  end # class SetType
end # module Finitio
