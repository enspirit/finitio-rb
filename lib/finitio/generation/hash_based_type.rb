module Finitio
  module HashBasedType

    def generate_data(generator, world = nil)
      tuple = {}
      heading.each do |a|
        if a.required or generator.flip_coin
          tuple[a.name.to_sym] = generator.call(a.type, world)
        end
      end
      tuple
    end

  end # class HashBasedType
end # module Finitio
