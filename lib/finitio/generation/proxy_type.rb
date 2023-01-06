module Finitio
  class ProxyType

    def generate_data(*args, &bl)
      @target&.generate_data(*args, &bl)
    end

  end # class ProxyType
end # module Finitio
