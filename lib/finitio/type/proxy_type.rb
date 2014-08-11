module Finitio
  class ProxyType < Type

    def initialize(target_name, target = nil)
      unless target_name.is_a?(String)
        raise ArgumentError, "String expected for type name, got `#{target_name}`"
      end

      @target_name = target_name
      @target = target
    end
    attr_reader :target_name, :target

    [
      :representator,
      :name,
      :name=,
      :default_name,
      :dress,
      :undress,
      :include?,
      :==,
      :eql?,
      :hash,
      :to_s
    ].each do |meth|
      define_method(meth) do |*args, &bl|
        raise Error, "Proxy not resolved" unless @target
        @target.send(meth, *args, &bl)
      end
    end

    def resolve(system)
      @target = system.fetch(target_name) do
        raise Error, "No such type `#{target_name}`"
      end
    end

  end # class ProxyType
end # module Finitio
