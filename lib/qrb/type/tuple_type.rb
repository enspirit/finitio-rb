module Qrb
  class TupleType < Type

    def initialize(name, heading)
      unless heading.is_a?(Heading)
        raise ArgumentError, "Heading expected, got `#{heading}`"
      end

      super(name)
      @heading = heading
    end
    attr_reader :heading

    def up(arg, handler = UpHandler.new)
      handler.branch(self, arg) do
        handler.fail! unless arg.is_a?(Hash)

        # Uped values, i.e. tuple under construction
        uped = {}

        # Check the tuple arity and fail fast if extra attributes
        # (missing attributes are handled just after)
        if arg.size > heading.size
          extra = arg.keys.map(&:to_s) - heading.map{|attr| attr.name.to_s }
          handler.fail!(message: "Unrecognized attribute `#{extra.first}`")
        end

        # Up each attribute in turn now. Fail on missing ones.
        heading.each do |attribute|
          val = attribute.fetch_on(arg) do
            handler.fail!(message: "Missing attribute `#{attribute.name}`")
          end
          uped[attribute.name] = attribute.type.up(val, handler)
        end

        uped
      end
    end

    def ==(other)
      return nil unless other.is_a?(TupleType)
      heading == other.heading
    end
    alias :eql? :==

    def hash
      heading.hash
    end

  end # class TupleType
end # module Qrb
