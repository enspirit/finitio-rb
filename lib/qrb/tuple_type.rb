module Qrb
  class TupleType < Type

    def initialize(name, heading)
      unless heading.is_a?(Heading)
        raise "Heading expected, got `#{heading}`"
      end

      super(name)
      @heading = heading
    end
    attr_reader :heading

    def up(arg)
      up_error!(arg) unless arg.is_a?(Hash)

      # uped values
      uped = {}

      # check the tuple arity and raise ASAP
      if arg.size > heading.size
        extra = arg.keys.map(&:to_s) - heading.map{|attr| attr.name.to_s }
        msg = "Unrecognized attribute `#{extra.first}` for #{to_s}"
        raise UpError.new(msg)
      end

      # check each attribute in turn
      heading.each do |attribute|
        val = attribute.fetch_on(arg){
          raise UpError, "Missing attribute `#{attribute.name}` for #{to_s}"
        }
        begin
          uped[attribute.name] = attribute.type.up(val)
        rescue UpError => cause
          msg = "Invalid attribute `#{attribute.name}` for #{to_s}"
          raise UpError.new(msg, cause)
        end
      end

      uped
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
