module Finitio
  class Contract
    include Metadata

    def initialize(infotype, dresser, undresser, name = nil, metadata = nil)
      unless infotype.is_a?(Type)
        raise ArgumentError, "Type expected, got `#{infotype}`"
      end
      unless dresser.respond_to?(:call)
        raise ArgumentError, "r(:call) expected, got `#{dresser}`"
      end
      unless undresser.respond_to?(:call)
        raise ArgumentError, "r(:call) expected, got `#{undresser}`"
      end
      unless name.nil? or name.is_a?(Symbol)
        raise ArgumentError, "Symbol expected, got `#{name}`"
      end

      @name      = name
      @infotype  = infotype
      @dresser   = dresser
      @undresser = undresser
      @metadata  = metadata
    end
    attr_reader :name, :infotype, :dresser, :undresser

    def bind_ruby_type(clazz)
      @dresser   = clazz.method(name.to_sym)
      @undresser = clazz.instance_method(:"to_#{name}")
    end

  end # class Contract
end # module Finitio
