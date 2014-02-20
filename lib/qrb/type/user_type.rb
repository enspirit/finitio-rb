require 'set'
module Qrb
  class UserType < Type

    def initialize(contracts, name = nil)
      unless contracts.is_a?(Hash)
        raise ArgumentError, "Hash expected, got `#{contracts}`"
      end

      super(name)
      @contracts = contracts.freeze
    end
    attr_reader :contracts

    def default_name
      "Unnamed"
    end

    def up(value, handler = UpHandler.new)
      # Try each contract in turn. Do nothing on UpError as
      # the next candidate could be the good one! Return the
      # first successfully uped.
      contracts.each_pair do |infotype, upper|

        # First make the up on the information type
        success, uped = handler.just_try do
          infotype.up(value, handler)
        end
        next unless success

        # Seems nice, just try to get one stage higher now
        success, uped = handler.just_try do
          upper.call(uped)
        end
        return uped if success

      end

      # No one succeed, just fail
      handler.failed!(self, value)
    end

  end # class UserType
end # module Qrb
