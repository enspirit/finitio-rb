module Finitio
  class ProxyType

    def generate_data(*args, &bl)
      # Proxy type is supposed to be used only on recursive types
      # so we can't go further to avoid a infinite recursion
      {}
    end

  end # class ProxyType
end # module Finitio
