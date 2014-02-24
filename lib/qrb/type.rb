module Qrb
  #
  # Abstract class for Q type (generators).
  #
  class Type

    def initialize(name)
      unless name.nil? or name.is_a?(String)
        raise ArgumentError, "String expected for type name, got `#{name}`"
      end
      @name = name
    end

    def name
      @name || default_name
    end

    def name=(n)
      raise Error, "Name already set to `#{@name}`" unless @name.nil?
      @name = n
    end

    def to_s
      name.to_s
    end

    def from_q(*args)
      raise NotImplementedError, "Missing #{self.class.name}#up"
    end

    def undress(*args)
      from_q(*args)
    end

  protected

    def set_equal?(s1, s2)
      s1.size == s2.size and (s1-s2).empty?
    end

    def set_hash(arg)
      arg.map(&:hash).reduce(:^)
    end

  end # class Type
end # module Qrb
require_relative 'type/builtin_type'
require_relative 'type/union_type'
require_relative 'type/sub_type'
require_relative 'type/seq_type'
require_relative 'type/set_type'
require_relative 'type/tuple_type'
require_relative 'type/relation_type'
require_relative 'type/ad_type'
