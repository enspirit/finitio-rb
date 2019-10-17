module Finitio
  class Generation
    class Heuristic
      class Constant < Heuristic

        CONSTANTS = {
          NilClass => nil,
          TrueClass => true,
          FalseClass => false,
          Integer => 99,
          Float => 99.99,
          String => "Hello world",
          Date => Date.today,
          Time => Time.now,
          DateTime => DateTime.now,
        }

        def call(ruby_type, generator, world = nil)
          CONSTANTS.fetch(ruby_type) do
            CONSTANTS.each_pair do |clazz, value|
              return value if clazz >= ruby_type
            end
            throw :unfound
          end
        end

      end # class Constant
    end # class Heuristic
  end # class Generation
end # module Finition
