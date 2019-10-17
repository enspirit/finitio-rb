module Finitio
  class BuiltinType

    def generate_data(generator, world = nil)
      generator.heuristic.call(ruby_type, generator, world)
    end

  end # class BuiltinType
end # module Finitio
