module Finitio
  # Part of the compilation schema, this proxy resolver replaces
  # proxies by their real Type instance.
  #
  # Given that Finitio can support recursive types, we do this in
  # two passes:
  #   1. Replace proxy types by rewrite (see Type#resolve_proxies)
  #      in a depth first search.
  #   2. If a loop is found, recreate a late ProxyType, that is then
  #      bound later by mutation.
  #
  # So ProxyType may still be present in the type chain, but will
  # only correspond to recursive types.
  class ProxyResolver
    def resolve!(system)
      @system = system
      @built = {}
      @building = {}
      @late_proxies = []
      system.types.each_key do |name|
        fetch(name)
      end
      @late_proxies.each do |proxy|
        proxy.bind!(self)
      end
      system.dup(@built)
    end

    def fetch(name, &bl)
      @built[name] || build_it(name) || import_it(name, &bl)
    end

    def build_it(name)
      if under_build = @building[name]
        proxy = ProxyType.new(name)
        @late_proxies << proxy
        proxy
      else
        return nil unless type = @system.fetch(name, false){ nil }

        @building[name] = type
        @built[name] = type.resolve_proxies(self)
        @building[name] = nil
        @built[name]
      end
    end

    def import_it(name, &bl)
      @system.fetch_on_imports(name, &bl)
    end
  end # class ProxyResolver
end # module Finitio
