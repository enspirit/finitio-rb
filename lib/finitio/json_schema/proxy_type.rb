module Finitio
  class ProxyType

    def to_json_schema(*args, &bl)
      # ProxyType is supposed to be used only for recursive types.
      # We don't have support for references yet, so let just
      # generate an object here in the mean time.
      { type: "object" }
    end

  end # module ProxyType
end # module UnionType
