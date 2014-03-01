module Qrb
  module Syntax
    module System

      def compile(system)
        definitions.compile(system)
        if type
          system.main = type.compile(system)
        end
        system
      end

    end # module System
  end # module Syntax
end # module Qrb
