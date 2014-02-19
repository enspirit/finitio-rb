module Qrb
  class BuiltinType < Type

    def initialize(name, ruby_type)
      super(name)
      @ruby_type = ruby_type
    end
    attr_reader :ruby_type

    def up(value)
      raise up_error!(value) unless ruby_type===value
      value
    end

    def ==(other)
      return nil unless other.is_a?(BuiltinType)
      other.ruby_type==ruby_type
    end
    alias :eql? :==

    def hash
      ruby_type.hash
    end

  end # class BuiltinType
end # module Qrb
