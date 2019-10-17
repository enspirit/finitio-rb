module Finitio
  #
  # Abstract class for Finitio type (generators).
  #
  class Type
    include Metadata

    def initialize(name, metadata)
      unless name.nil? or name.is_a?(String)
        raise ArgumentError, "String expected for type name, got `#{name}`"
      end
      unless metadata.nil? or metadata.is_a?(Hash)
        raise ArgumentError, "Hash expected for metadata, got `#{metadata}`"
      end
      @name     = name
      @metadata = metadata
    end

    def anonymous?
      @name.nil?
    end

    def named?
      !anonymous?
    end

    def default_name
      raise NotImplementedError, "Missing #{self.class.name}#default_name"
    end

    def name
      @name || default_name
    end

    def name=(n)
      raise Error, "Name already set to `#{@name}`" unless @name.nil?
      @name = n
    end

    # Check if `value` belongs to this type. Returns true if it's the case,
    # false otherwise.
    #
    # For belonging to the type, `value` MUST be a valid representation, not
    # an 'approximation' or some 'similar' representation. In particular,
    # returning true means that no dressing is required for using `value` as a
    # proper one. Similarly, the method MUST always return true on a value
    # directly obtained through `dress`.
    #
    def include?(value)
      raise NotImplementedError, "Missing #{self.class.name}#include?"
    end

    def dress(*args)
      raise NotImplementedError, "Missing #{self.class.name}#dress"
    end

    def suppremum(other)
      return self if other == self
      other._suppremum(self)
    end

    def _suppremum(other)
      UnionType.new([other, self])
    end
    protected :_suppremum

    def unconstrained
      self
    end

    def to_s
      name.to_s
    end

    def ==(other)
      super || [ProxyType, AliasType].any?{|t|
        other.is_a?(t) && other == self
      }
    end

    def resolve_proxies(system)
      raise NotImplementedError, "resolve_proxies must be overriden"
    end

  protected

    def set_equal?(s1, s2)
      s1.size == s2.size and (s1-s2).empty?
    end

    def set_hash(arg)
      arg.map(&:hash).reduce(:^)
    end

  end # class Type
end # module Finitio
require_relative 'type/collection_type'
require_relative 'type/heading_based_type'
require_relative 'type/hash_based_type'
require_relative 'type/rel_based_type'
require_relative 'type/proxy_type'
require_relative 'type/alias_type'
require_relative 'type/any_type'
require_relative 'type/builtin_type'
require_relative 'type/union_type'
require_relative 'type/sub_type'
require_relative 'type/seq_type'
require_relative 'type/set_type'
require_relative 'type/struct_type'
require_relative 'type/tuple_type'
require_relative 'type/multi_tuple_type'
require_relative 'type/relation_type'
require_relative 'type/multi_relation_type'
require_relative 'type/ad_type'
require_relative 'type/high_order_type'
