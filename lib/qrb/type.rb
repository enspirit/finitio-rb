module Qrb
  class Type

    def initialize(name)
      unless name.is_a?(String)
        raise ArgumentError, "String expected for type name, got `#{name}`"
      end
      @name = name
    end
    attr_reader :name

    def to_s
      name.to_s
    end

    def up(*args)
      raise NotImplementedError, "Missing #{self.class.name}#up"
    end

  protected

    def set_equal?(s1, s2)
      s1.size == s2.size and (s1-s2).empty?
    end

    def set_hash(arg)
      arg.map(&:hash).reduce(:^)
    end

    def up_error_message(value)
      "Invalid value `#{value}` for #{to_s}"
    end

    def up_error!(value, cause = nil)
      raise UpError.new(up_error_message(value), cause)
    end

  end # class Type
end # module Qrb
require_relative 'type/builtin_type'
require_relative 'type/union_type'
require_relative 'type/sub_type'
require_relative 'type/tuple_type'
require_relative 'type/relation_type'
require_relative 'type/user_type'
