module Finitio
  module HashBasedType

    def representator
      rep = {}
      heading.each do |attr|
        rep[attr.name] = rep[attr.type.representator]
      end
      rep
    end

    def include?(value)
      value.is_a?(Hash) &&
      heading.all?{|a|
        value.has_key?(a.name) ? a.type.include?(value[a.name]) : true
      } &&
      !missing_attr?(value) &&
      valid_extra_attrs?(value)
    end

    # Convert `value` (supposed to be Hash) to a Tuple, by checking attributes
    # and applying `dress` on them in turn. Raise an error if any attribute
    # is missing or unrecognized, as well as if any sub transformation fails.
    def dress(value, handler = DressHelper.new)
      handler.failed!(self, value) unless looks_a_tuple?(value)

      # Check for missing attributes
      unless (missing = missing_attrs(value, true)).empty?
        handler.fail!("Missing attribute `#{missing.first}`")
      end

      # Uped values, i.e. tuple under construction
      uped = {}

      # Check for extra attributes
      extra = extra_attrs(value, true)
      case extra_type = heading.extra_type
      when NilClass
        handler.fail!("Unrecognized attribute `#{extra.first}`") unless extra.empty?
      when ANY_TYPE
        # ok, nothing to do
      else
        extra.each do |attr|
          handler.deeper(attr) do
            attr_value = value.fetch(attr){|k| value.fetch(attr.to_sym) }
            uped[attr.to_sym] = extra_type.dress(attr_value, handler)
          end
        end
      end

      # Up each attribute in turn now. Fail on missing ones.
      heading.each do |attribute|
        present = true
        val = attribute.fetch_on(value){ present = false }
        next unless present
        handler.deeper(attribute.name) do
          uped[attribute.name] = attribute.type.dress(val, handler)
        end
      end

      uped
    end

  protected

    def looks_a_tuple?(value)
      value.is_a?(Hash) or [:keys, :fetch].all?{|k| value.respond_to?(k) }
    end

    def attr_names
      @attr_names ||= heading.map(&:name)
    end

    def req_attr_names
      @req_attr_names ||= heading.select(&:required).map(&:name)
    end

    def attrs(as, to_s)
      to_s ? as.map(&:to_s) : as
    end

    def extra_attrs(value, to_s = false)
      attrs(value.keys, to_s) - attrs(attr_names, to_s)
    end

    def missing_attrs(value, to_s = false)
      attrs(req_attr_names, to_s) - attrs(value.keys, to_s)
    end

    def missing_attr?(value, to_s = false)
      !missing_attrs(value, to_s).empty?
    end

    def valid_extra_attrs?(value)
      extra = self.extra_attrs(value)
      return extra.empty? unless heading.allow_extra?
      extra_type = heading.extra_type
      return true if extra_type == ANY_TYPE
      extra.all?{|attr| extra_type.include?(value[attr]) }
    end

  end # module HashBasedType
end # module Finitio
