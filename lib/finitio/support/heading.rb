module Finitio
  #
  # Helper class for tuple and relation types.
  #
  # A heading is a set of attributes, with the constraint that no two
  # attributes have the same name.
  #
  class Heading
    include Enumerable

    DEFAULT_OPTIONS = { allow_extra: false }.freeze

    def initialize(attributes, options = nil)
      @attributes = normalize_attributes(attributes)
      @options    = normalize_options(options)
    end

    def [](attrname)
      @attributes[attrname]
    end

    def fetch(attrname)
      @attributes.fetch(attrname) do
        raise Error, "No such attribute `#{attrname}`"
      end
    end

    def size
      @attributes.size
    end

    def empty?
      size == 0
    end

    def multi?
      allow_extra? || any?{|attr| not(attr.required?) }
    end

    def allow_extra?
      !!options[:allow_extra]
    end

    def allow_extra
      options[:allow_extra]
    end
    alias :extra_type :allow_extra

    def each(&bl)
      return to_enum unless bl
      @attributes.values.each(&bl)
    end

    def to_name
      name = map(&:to_name).join(', ')
      if allow_extra?
        name << ", " unless empty?
        name << "..."
        name << ": #{allow_extra.name}" unless allow_extra == ANY_TYPE
      end
      name
    end

    def pretty_string(offset)
      s = @attributes.values.map {|v|
        v.pretty_string(offset)
      }.join(",\n")
      if allow_extra?
        s << ",\n" + (' ' * offset) unless empty?
        s << "..."
        s << ": #{allow_extra.name}" unless allow_extra == ANY_TYPE
      end
      s
    end

    def looks_similar?(other)
      return self if other == self
      shared, mine, yours = Support.compare_attrs(attributes, other.attributes)
      shared.length >= mine.length && shared.length >= yours.length
    end

    def suppremum(other)
      raise ArgumentError unless other.is_a?(Heading)
      return self if other == self
      options = { allow_extra: allow_extra? || other.allow_extra? }
      shared, mine, yours = Support.compare_attrs(attributes, other.attributes)
      attributes = shared.map{|attr|
        a1, o1 = self[attr], other[attr]
        Attribute.new(attr, a1.type.suppremum(o1.type), a1.required && o1.required)
      }
      attributes += mine.map{|attrname|
        attr = self[attrname]
        Attribute.new(attr.name, attr.type, false)
      }
      attributes += yours.map{|attrname|
        attr = other[attrname]
        Attribute.new(attr.name, attr.type, false)
      }
      Heading.new(attributes, options)
    end

    def ==(other)
      return nil unless other.is_a?(Heading)
      attributes == other.attributes && options == other.options
    end

    def hash
      self.class.hash ^ attributes.hash ^ options.hash
    end

    attr_reader :attributes, :options
    protected   :attributes, :options

    def resolve_proxies(system)
      as = attributes.map{|k,a| a.resolve_proxies(system) }
      Heading.new(as, options)
    end

    def unconstrained
      Heading.new(attributes.values.map{|a| a.unconstrained }, options)
    end

  private

    def normalize_attributes(attrs)
      unless attrs.respond_to?(:each)
        raise ArgumentError, "Enumerable[Attribute] expected"
      end

      attributes = {}
      attrs.each do |attr|
        unless attr.is_a?(Attribute)
          raise ArgumentError, "Enumerable[Attribute] expected, got a `#{attr.inspect}`"
        end
        if attributes[attr.name]
          raise ArgumentError, "Attribute names must be unique"
        end
        attributes[attr.name] = attr
      end
      attributes.freeze
    end

    def normalize_options(opts)
      options = DEFAULT_OPTIONS.dup
      options = options.merge(opts) if opts
      options[:allow_extra] = case extra = options[:allow_extra]
      when TrueClass            then ANY_TYPE
      when NilClass, FalseClass then nil
      when Type                 then extra
      else
        raise ArgumentError, "Unrecognized allow_extra: #{extra}"
      end
      options.freeze
    end

  end # class Heading
end # class Finitio
