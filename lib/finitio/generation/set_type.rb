module Finitio
  class SetType

    def generate_data(generator, world = nil)
      coll = []
      generator.collection_size.times do
        coll << generator.call(elm_type, world)
      end
      coll.uniq
    end

  end # class SetType
end # module Finitio
