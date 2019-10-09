require 'set'
module Finitio
  #
  # The Abtract/Algebraic Data Type is a generator to build user-defined
  # information types in a more abstract way than using sub types. For
  # instance, a Color could be defined as follows:
  #
  #     Color := <Rgb> {r: Byte, g: Byte, b: Byte},
  #              <Hex> String( s | s =~ /^#[0-9a-f]{6}$/i )
  #
  # Such a declaration does not define a new type by *subtyping* but instead
  # declares so-called possible representations for the color. Here, two
  # possible representations are defined: one is a rgb triple through a Tuple
  # type, the other is an hexadecimal notation through a subset of String.
  #
  # Given an AdType, Finitio requires special dress/undress function pairs to
  # encode/decode from the type to the concrete representations and vice versa.
  # This pair of functions is called the "information contract".
  #
  # This class allows capturing such information types. For instance,
  #
  #     # This is the concrete representation of Finitio's Color, through a
  #     # usual Ruby ADT (we call it ColorImpl here to avoid confusion, but in
  #     # practice one would simply call it Color).
  #     class ColorImpl
  #       # ... your usual color implementation
  #     end
  #
  #     # The RGB info type: {r: Byte, g: Byte, b: Byte}
  #     rgb_infotype  = TupleType.new(...)
  #
  #     # The RGB contract converter, an object that responds to `call` to
  #     # convert from a valid Hash[r: Fixnum, ...] to a ColorImpl instance.
  #     rgb_contract = ...
  #
  #     AdType.new(ColorImpl, rgb: [rgb_infotype, rgb_contract], hex: ...)
  #
  # The ruby ADT class is of course used as concrete representation of the
  # AdType, that is,
  #
  #     R(Color) = ColorImpl
  #
  # Accordingly, the `dress` transformation function has the following
  # signature:
  #
  #     dress :: Alpha  -> Color     throws TypeError
  #     dress :: Object -> ColorImpl throws TypeError
  #
  class AdType < Type

    def initialize(ruby_type, contracts, name = nil, metadata = nil)
      unless ruby_type.nil? or ruby_type.is_a?(Module)
        raise ArgumentError, "Module expected, got `#{ruby_type}`"
      end
      unless contracts.is_a?(Array) &&
             contracts.all?{|c| c.is_a?(Contract) }
        raise ArgumentError, "[Contract] expected, got `#{contracts}`"
      end

      super(name, metadata)
      @ruby_type = ruby_type
      @contracts = contracts.freeze
    end
    attr_reader :ruby_type, :contracts

    alias :representator :ruby_type

    def ruby_type=(ruby_type)
      @ruby_type = ruby_type
      @contracts.each do |contract|
        contract.bind_ruby_type(ruby_type)
      end
    end

    def [](name)
      contracts.find{|c| c.name == name }
    end

    def contract_names
      contracts.map(&:name)
    end

    def default_name
      (ruby_type && ruby_type.name.to_s) || "Anonymous"
    end

    def include?(value)
      ruby_type === value
    end

    def dress(value, handler = DressHelper.new)
      # Up should be idempotent with respect to the ADT
      return value if ruby_type and value.is_a?(ruby_type)

      # Dressed value and first exception
      dressed, error = nil, nil

      # Try each contract in turn. Do nothing on TypeError as
      # the next candidate could be the good one! Return the
      # first successfully dressed.
      contracts.each do |contract|

        # First make the dress transformation on the information type
        success, dressed = handler.just_try do
          contract.infotype.dress(value, handler)
        end

        # Save very first error on failure
        unless success
          error ||= dressed
          next
        end

        # Seems nice, just try to get one stage higher now
        success, dressed = handler.just_try(StandardError) do
          contract.dresser.call(dressed)
        end

        if success
          if ruby_type && !dressed.is_a?(ruby_type)
            raise "Invalid IC dresser (#{contract.dresser}):"\
                  " #{ruby_type} expected, got #{dressed.class}"
          end
          return dressed
        else
          error ||= dressed
        end
      end

      # No one succeeded, just fail
      handler.failed!(self, value, error)
    end

    def hash
      ruby_type.hash ^ contracts.hash
    end

    def ==(other)
      super || (
        other.is_a?(AdType) &&
        ruby_type == other.ruby_type &&
        contracts == other.contracts
      )
    end
    alias :eql? :==

    def resolve_proxies(system)
      AdType.new(ruby_type, contracts.map{|t| t.resolve_proxies(system)}, name, metadata)
    end

  end # class AdType
end # module Finitio
