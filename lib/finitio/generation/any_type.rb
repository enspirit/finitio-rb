module Finitio
  class AnyType

    def generate_data(generator, world = nil)
      candidates = [NilClass, String, Integer, Float]
      type = generator.flip_one_out_of(candidates)
      generator.heuristic.call(type, generator, world)
    end

  end # class AnyType
end # module Finitio
