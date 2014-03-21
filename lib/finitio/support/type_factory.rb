module Finitio
  class TypeFactory

    DSL_METHODS = [
      :attribute,
      :heading,
      :constraints,
      :any,
      :builtin,
      :adt,
      :subtype,
      :union,
      :seq,
      :set,
      :tuple,
      :relation,
      :type
    ]

    ################################################################## Factory

    def type(type, name = nil, &bl)
      return subtype(type(type, name), bl) if bl
      case type
      when Type
        type
      when Module
        BuiltinType.new(type, name || type.name.to_s)
      when Hash
        tuple(type, name)
      when Array
        fail!("Array of arity 1 expected, got `#{type}`") unless type.size==1
        seq(type.first, name)
      when Set
        fail!("Set of arity 1 expected, got `#{type}`") unless type.size==1
        sub = type(type.first)
        sub.is_a?(TupleType) ? relation(sub.heading, name) : set(sub, name)
      when Range
        clazz = [type.begin, type.end].map(&:class).uniq
        fail!("Unsupported range `#{type}`") unless clazz.size==1
        subtype(clazz.first, type)
      when Regexp
        subtype(String, type)
      else
        fail!("Unable to factor a Finitio::Type from `#{type}`")
      end
    end

    ########################################################### Type Arguments

    def ruby_type(type)
      unless type.is_a?(Module)
        fail!("Ruby module expected, got `#{type}`")
      end

      type
    end

    def name(name)
      unless name.nil? or (name.is_a?(String) and name.strip.size > 1)
        fail!("Wrong type name `#{name}`")
      end

      name.nil? ? nil : name.strip
    end

    def constraints(constraints = nil, &bl)
      constrs = {}
      constrs[:predicate] = bl if bl
      constrs[:predicate] = constraints unless constraints.is_a?(Hash)
      constrs.merge!(constraints)       if constraints.is_a?(Hash)
      constrs
    end

    def attribute(name, type)
      Attribute.new(name, type(type))
    end

    def attributes(attributes)
      case attributes
      when Hash
        attributes.each_pair.map do |name, type|
          attribute(name, type)
        end
      else
        fail!("Hash expected, got `#{attributes}`")
      end
    end

    def heading(heading)
      case heading
      when Heading
        heading
      when TupleType, RelationType
        heading.heading
      when Hash
        Heading.new(attributes(heading))
      else
        fail!("Heading expected, got `#{heading}`")
      end
    end

    def contracts(contracts)
      unless contracts.is_a?(Hash)
        fail!("Hash expected, got `#{contracts}`")
      end
      unless (invalid = contracts.keys.reject{|k| k.is_a?(Symbol) }).empty?
        fail!("Invalid contract names `#{invalid}`")
      end

      contracts
    end

    ########################################################## Type generators

    def any(name = nil)
      name = name(name)

      AnyType.new(name)
    end

    def builtin(ruby_type, name = nil)
      ruby_type = ruby_type(ruby_type)
      name      = name(name)

      BuiltinType.new(ruby_type, name)
    end

    def adt(ruby_type, contracts, name = nil)
      ruby_type = ruby_type(ruby_type) if ruby_type
      contracts = contracts(contracts)
      name      = name(name)

      AdType.new(ruby_type, contracts, name)
    end

    ### Sub and union

    def subtype(super_type, constraints = nil, name = nil, &bl)
      super_type  = type(super_type)
      constraints = constraints(constraints, &bl)
      name        = name(name)

      SubType.new(super_type, constraints, name)
    end

    def union(*args)
      candidates, name = [], nil
      args.each do |arg|
        case arg
        when Array  then candidates = arg.map{|t| type(t) }
        when String then name = name(arg)
        else
          candidates << type(arg)
        end
      end

      UnionType.new(candidates, name)
    end

    ### Collections

    def seq(elm_type, name = nil)
      elm_type = type(elm_type)
      name     = name(name)

      SeqType.new(elm_type, name)
    end

    def set(elm_type, name = nil)
      elm_type = type(elm_type)
      name     = name(name)

      SetType.new(elm_type, name)
    end

    ### Tuples and relations

    def tuple(heading, name = nil)
      heading = heading(heading)
      name    = name(name)

      TupleType.new(heading, name)
    end

    def relation(heading, name = nil)
      heading = heading(heading)
      name    = name(name)

      RelationType.new(heading, name)
    end

  private

    def fail!(message)
      raise ArgumentError, message, caller
    end

  end # class TypeBuilder
end # module Finitio
