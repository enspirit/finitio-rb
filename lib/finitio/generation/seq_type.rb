module Finitio
  class SeqType

    def generate_data(generator, world = nil)
      coll = []
      generator.collection_size.times do
        coll << generator.call(elm_type, world)
      end
      coll
    end

  end # class SeqType
end # module Finitio
