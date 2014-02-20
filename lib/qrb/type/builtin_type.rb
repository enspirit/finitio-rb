module Qrb
  class BuiltinType < Type

    def initialize(ruby_type, name = nil)
      super(name)
      @ruby_type = ruby_type
    end
    attr_reader :ruby_type

    def up(value, handler = UpHandler.new)
      handler.failed!(self, value) unless ruby_type===value
      value
    end

    def default_name
      @ruby_type.name.to_s
    end

    def ==(other)
      return false unless other.is_a?(BuiltinType)
      other.ruby_type==ruby_type
    end
    alias :eql? :==

    def hash
      self.class.hash ^ ruby_type.hash
    end

  end # class BuiltinType
end # module Qrb
