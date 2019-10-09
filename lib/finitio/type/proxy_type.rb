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

    def default_name
      "_#{target_name}_"
    end

    def resolve_proxies(system)
      system.fetch(target_name){
        raise Error, "No such type `#{target_name}` in #{system}"
      }
    end

  end # class ProxyType
end # module Finitio
