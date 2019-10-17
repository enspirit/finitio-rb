module Finitio
  module RelBasedType

    def generate_data(generator, world = nil)
      coll = []
      generator.collection_size.times do
        coll << generator.call(tuple_type, world)
      end
      coll.uniq
    end

  end # module RelBasedType
end # module Finitio
