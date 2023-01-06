module Finitio
  class ProxyType

    def to_json_schema(*args, &bl)
      if @target
        @target.to_json_schema(*args, &bl)
      else
        "object"
      end
    end

  end # module ProxyType
end # module UnionType
