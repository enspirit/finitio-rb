module Qrb
  class RealmBuilder

    def initialize(realm = Realm.new)
      unless realm.is_a?(Realm)
        raise ArgumentError, "Qrb::Realm expected, got `#{realm}`"
      end
      @realm  = realm
      @stacks = Hash.new{|h,k| h[k] = [] }
    end
    attr_reader :realm

    #################################################### Stack-based Arguments

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

    def constraints(constraints)
      unless constraints.is_a?(Hash)
        constraints = { predicate: constraints }
      end

      constraints
    end

    def attribute(name, type)
      Attribute.new(name, type(type))
    end

    def attributes(attributes)
      attributes = case attributes
      when Hash
        attributes.each_pair.map do |name, type|
          attribute(name, type)
        end
      else
        fail!("Hash expected, got `#{attributes}`")
      end

      attributes
    end

    def heading(heading)
      heading = case heading
      when Heading
        heading
      when TupleType, RelationType
        heading.heading
      when Hash
        Heading.new(attributes(heading))
      else
        fail!("Heading expected, got `#{heading}`")
      end

      heading
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

    def type(type)
      type = case type
      when Type
        type
      when Module
        realm.fetch(type.name.to_s){|name|
          realm.add_type(BuiltinType.new(type, name))
        }
      else
        fail!("Qrb::Type|Module expected, got `#{type}`")
      end

      type
    end

    ########################################################## Type generators

    def builtin(ruby_type, name = nil)
      ruby_type = ruby_type(ruby_type)
      name      = name(name)

      BuiltinType.new(ruby_type, name)
    end

    def builtin!(*args)
      add_type builtin(*args)
    end

    def adt(ruby_type, contracts, name = nil)
      ruby_type = ruby_type(ruby_type)
      contracts = contracts(contracts)
      name      = name(name)

      AdType.new(ruby_type, contracts, name)
    end

    def adt!(*args)
      add_type adt(*args)
    end

    ### Sub and union

    def subtype(super_type, constraints, name = nil)
      super_type  = type(super_type)
      constraints = constraints(constraints)
      name        = name(name)

      SubType.new(super_type, constraints, name)
    end

    def subtype!(*args)
      add_type subtype(*args)
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

    def union!(*args)
      add_type union(*args)
    end

    ### Collections

    def seq(elm_type, name = nil)
      elm_type = type(elm_type)
      name     = name(name)

      SeqType.new(elm_type, name)
    end

    def seq!(*args)
      add_type seq(*args)
    end

    def set(elm_type, name = nil)
      elm_type = type(elm_type)
      name     = name(name)

      SetType.new(elm_type, name)
    end

    def set!(*args)
      add_type set(*args)
    end

    ### Tuples and relations

    def tuple(heading, name = nil)
      heading = heading(heading)
      name    = name(name)

      TupleType.new(heading, name)
    end

    def tuple!(*args)
      add_type tuple(*args)
    end

    def relation(heading, name = nil)
      heading = heading(heading)
      name    = name(name)

      RelationType.new(heading, name)
    end

    def relation!(*args)
      add_type relation(*args)
    end

    ######################################################### Realm management

    def add_type(type)
      realm.add_type(type)
    end

  private

    def fail!(message)
      raise Error, message, caller
    end

  end # class TypeBuilder
end # module Qrb
