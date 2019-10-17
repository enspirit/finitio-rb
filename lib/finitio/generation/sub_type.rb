module Finitio
  class SubType

    def generate_data(generator, world = nil)
      generator.call(super_type, world)
    end

  end # class SubType
end # module Finitio
