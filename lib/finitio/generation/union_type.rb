module Finitio
  class UnionType

    def generate_data(generator, world = nil)
      picked = generator.flip_one_out_of(candidates)
      generator.call(picked, world)
    end

  end # class UnionType
end # module Finitio
