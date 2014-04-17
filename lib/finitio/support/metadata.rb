module Finitio
  module Metadata

    EMPTY_METADATA = {}.freeze

    def metadata
      @metadata || EMPTY_METADATA
    end

    def metadata?
      !@metadata.nil?
    end

    def metadata=(hash)
      raise "Metadata already set to #{@metadata.inspect}" unless @metadata.nil?
      @metadata = hash
    end

  end # module Metadata
end # module Finitio
