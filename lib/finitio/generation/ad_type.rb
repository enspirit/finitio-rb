module Finitio
  class AdType

    def generate_data(generator, world = nil)
      infotype = generator.flip_one_out_of(contracts).infotype
      generator.call(infotype, world)
    end

  end # class AliasType
end # module Finitio
