module Qrb
  class BuiltinType < Type

    def initialize(name, ruby_type)
      super(name)
      @ruby_type = ruby_type
    end
    attr_reader :ruby_type

    def up(value, handler = UpHandler.new)
      handler.branch(self, value) do
        handler.fail! unless ruby_type===value
        value
      end
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
