module Finitio
  class ProxyType

    def to_json_schema(*args, &bl)
      @target.to_json_schema(*args, &bl) if @target
    end

  end # module ProxyType
end # module UnionType
