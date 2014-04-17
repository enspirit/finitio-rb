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
      :struct,
      :tuple,
      :multi_tuple,
      :relation,
      :multi_relation,
      :type,
      :proxy
    ]

    ################################################################## Factory

    def type(type, name = nil, metadata = nil, &bl)
      return subtype(type(type, name, metadata), bl) if bl
      case type
      when Type
        alias_type(type, name, metadata)
      when Module
        BuiltinType.new(type, name || type.name.to_s, metadata)
      when Hash
        tuple(type, name, metadata)
      when Array
        case type.size
        when 0
          fail!("Array of arity > 0 expected, got `#{type}`")
        when 1
          seq(type.first, name, metadata)
        else
          struct(type, name, metadata)
        end
      when Set
        fail!("Set of arity 1 expected, got `#{type}`") unless type.size==1
        sub = type(type.first)
        if sub.is_a?(TupleType)
          relation(sub.heading, name, metadata)
        else
          set(sub, name, metadata)
        end
      when Range
        clazz = [type.begin, type.end].map(&:class).uniq
        fail!("Unsupported range `#{type}`") unless clazz.size==1
        subtype(clazz.first, type, name, metadata)
      when Regexp
        subtype(String, type, name, metadata)
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

    def metadata(metadata)
      unless metadata.nil? or metadata.is_a?(Hash)
        fail!("Wrong metadata `#{metadata}`")
      end

      metadata
    end

    def constraint(constraint, name = nil)
      case constraint
      when Constraint then constraint
      else Constraint.new(constraint, name)
      end
    end

    def constraints(constraints = nil, &bl)
      constrs = []
      constrs << Constraint.new(bl) if bl
      case constraints
      when Hash
        constraints.each_pair do |name, cstr|
          constrs << constraint(cstr, name)
        end
      when Array
        constraints.each do |c|
          constrs << constraint(c)
        end
      else
        constrs << Constraint.new(constraints)
      end
      constrs
    end

    def attribute(name, type, required = true, metadata = nil)
      Attribute.new(name, type(type), required, metadata)
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

    def any(name = nil, metadata = nil)
      name = name(name)
      meta = metadata(metadata)

      AnyType.new(name, meta)
    end

    def builtin(ruby_type, name = nil, metadata = nil)
      ruby_type = ruby_type(ruby_type)
      name      = name(name)
      meta      = metadata(metadata)

      BuiltinType.new(ruby_type, name, meta)
    end

    def adt(ruby_type, contracts, name = nil, metadata = nil)
      ruby_type = ruby_type(ruby_type) if ruby_type
      contracts = contracts(contracts)
      name      = name(name)
      meta      = metadata(metadata)

      AdType.new(ruby_type, contracts, name, meta)
    end

    ### Sub and union

    def subtype(super_type, constraints = nil, name = nil, metadata = nil, &bl)
      super_type  = type(super_type)
      constraints = constraints(constraints, &bl)
      name        = name(name)
      meta        = metadata(metadata)

      SubType.new(super_type, constraints, name, metadata)
    end

    def union(*args)
      candidates, name, meta = [], nil, nil
      args.each do |arg|
        case arg
        when Array  then candidates = arg.map{|t| type(t) }
        when String then name = name(arg)
        else
          candidates << type(arg)
        end
      end

      UnionType.new(candidates, name, meta)
    end

    ### Collections

    def seq(elm_type, name = nil, metadata = nil)
      elm_type = type(elm_type)
      name     = name(name)
      meta     = metadata(metadata)

      SeqType.new(elm_type, name, meta)
    end

    def set(elm_type, name = nil, metadata = nil)
      elm_type = type(elm_type)
      name     = name(name)
      meta     = metadata(metadata)

      SetType.new(elm_type, name, meta)
    end

    def struct(component_types, name = nil, metadata = nil)
      component_types = component_types.map{|t| type(t) }
      name            = name(name)
      meta            = metadata(metadata)

      StructType.new(component_types, name, meta)
    end

    ### Tuples and relations

    def tuple(heading, name = nil, metadata = nil)
      heading = heading(heading)
      name    = name(name)
      meta    = metadata(metadata)

      TupleType.new(heading, name, meta)
    end

    def multi_tuple(heading, name = nil, metadata = nil)
      heading = heading(heading)
      name    = name(name)
      meta    = metadata(metadata)

      MultiTupleType.new(heading, name, meta)
    end

    def relation(heading, name = nil, metadata = nil)
      heading = heading(heading)
      name    = name(name)
      meta    = metadata(metadata)

      RelationType.new(heading, name, meta)
    end

    def multi_relation(heading, name = nil, metadata = nil)
      heading = heading(heading)
      name    = name(name)
      meta    = metadata(metadata)

      MultiRelationType.new(heading, name, meta)
    end

    def proxy(target_name)
      ProxyType.new(target_name)
    end

  private

    def alias_type(type, name, metadata)
      raise "Type expected `#{type}`" unless type.is_a?(Type)
      if (name && type.named?) or (metadata && type.metadata?)
        AliasType.new(type, name, metadata)
      else
        type.name = name         if name
        type.metadata = metadata if metadata
        type
      end
    end

    def fail!(message)
      raise ArgumentError, message, caller
    end

  end # class TypeBuilder
end # module Finitio
