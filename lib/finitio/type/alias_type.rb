module Finitio
  class AliasType < Type

    def initialize(target, name, metadata = nil)
      unless target.is_a?(Type)
        raise ArgumentError, "Type expected for target type, got `#{target}`"
      end
      if name.nil?
        raise ArgumentError, "Alias name cannot be nil"
      end

      super(name, metadata)
      @target = target
    end
    attr_reader :target

    def default_name
      @name
    end

    [
      :dress,
      :undress,
      :include?,
      :==,
      :eql?,
      :hash,
      :to_s
    ].each do |meth|
      define_method(meth) do |*args, &bl|
        @target.send(meth, *args, &bl)
      end
    end

  end # class AliasType
end # module Finitio
