module Finitio
  class ProxyResolutionScope
    def initialize(system)
      @system = system
      @built = {}
      @building = {}
    end
    attr_reader :built

    def fetch(name)
      @built[name] || build_it(name) || import_it(name, &bl)
    end

    def build_it(name)
      if under_build = @building[name]
        under_build
      else
        return nil unless type = @system.fetch(name, false)

        @building[name] = type
        @built[name] = type.resolve_proxies(self)
        @building[name] = nil
        @built[name]
      end
    end

    def import_it(name, &bl)
      @system.fetch_on_imports(name, &bl)
    end
  end # class ProxyResolutionScope
end # module Finitio
