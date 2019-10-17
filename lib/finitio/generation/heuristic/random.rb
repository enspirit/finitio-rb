module Finitio
  class Generation
    class Heuristic
      class Random < Heuristic

        RANDOMERS = {
          NilClass => nil,

          TrueClass => true,

          FalseClass => false,

          Integer => ->(_,g,_) {
            g.flip_one_out_of(1_000_000)
          },

          Float => ->(_,g,_) {
            g.flip_one_out_of(1_000_000)            
          },

          String => ->(_,g,_) {
            (1..3).map{ SecureRandom.hex(6) }.join(" ")
          },

          Date => ->(_,g,_) {
            Time.at(rand * Time.now.to_i).to_date
          },

          Time => ->(_,g,_) {
            Time.at(rand * Time.now.to_i)
          },

          DateTime => ->(_,g,_) {
            Time.at(rand * Time.now.to_i).to_datetime
          }
        }

        def call(ruby_type, generator, world = nil)
          r = RANDOMERS.fetch(ruby_type) do
            pair = RANDOMERS.find do |clazz, value|
              clazz >= ruby_type
            end
            throw :unfound unless pair
            pair.last
          end
          r.is_a?(Proc) ? r.call(ruby_type, generator, world) : r
        end

      end # class Random
    end # class Heuristic
  end # class Generation
end # module Finition
