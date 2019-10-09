module Finitio
  class FetchScope

    def initialize(parent, overrides)
      @parent, @overrides = parent, overrides
    end

    def fetch(name, &bl)
      @overrides.fetch(name) do
        @parent.fetch(name, &bl)
      end
    end

    def with(overrides)
      FetchScope.new(self, overrides)
    end

  end # class FetchScope
end # module Finitio
