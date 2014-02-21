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

      push(:ruby_type, type)
    end

    def name(name)
      unless name.is_a?(String) and name.strip.size > 1
        fail!("Wrong type name `#{name}`")
      end

      push(:name, name.strip)
    end

    def constraints(constraints)
      unless constraints.is_a?(Hash)
        constraints = { predicate: constraints }
      end

      push(:constraints, constraints)
    end

    def attribute(name, type)
      type(type)

      push(:attribute, Attribute.new(name, pop_one(:type)))
    end

    def attributes(attributes)
      attributes = case attributes
      when Hash
        attributes.each_pair do |name, type|
          attribute(name, type)
        end
      else
        fail!("Hash expected, got `#{attributes}`")
      end

      push(:attributes, pop_all(:attribute))
    end

    def heading(heading)
      heading = case heading
      when Heading
        heading
      when TupleType, RelationType
        heading.heading
      when Hash
        attributes(heading)
        Heading.new(pop_one(:attributes))
      else
        fail!("Heading expected, got `#{heading}`")
      end

      push(:heading, heading)
    end

    def contracts(contracts)
      unless contracts.is_a?(Hash)
        fail!("Hash expected, got `#{contracts}`")
      end
      unless (invalid = contracts.keys.reject{|k| k.is_a?(Symbol) }).empty?
        fail!("Invalid contract names `#{invalid}`")
      end

      push(:contracts, contracts)
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

      push(:type, type)
    end

    ########################################################## Type generators

    def builtin(ruby_type = nil, name = nil)
      ruby_type(ruby_type) if ruby_type
      name(name)           if name

      type BuiltinType.new(*pop(:ruby_type, :name))
    end

    def builtin!(*args)
      builtin(*args)
      add_type
    end

    def adt(ruby_type = nil, contracts = nil, name = nil)
      ruby_type(ruby_type) if ruby_type
      contracts(contracts) if contracts
      name(name)           if name

      type AdType.new(*pop(:ruby_type, :contracts, :name))
    end

    def adt!(*args)
      adt(*args)
      add_type
    end

    ### Sub and union

    def subtype(super_type = nil, constraints = nil, name = nil)
      type(super_type)         if super_type
      constraints(constraints) if constraints
      name(name)               if name

      type SubType.new(*pop(:type, :constraints, :name))
    end

    def subtype!(*args)
      subtype(*args)
      add_type
    end

    def union(*args)
      args.each do |arg|
        case arg
        when Array  then arg.map{|t| type(t) }
        when String then name(arg)
        else
          type(arg)
        end
      end

      type UnionType.new(pop_all(:type), pop_one(:name))
    end

    def union!(*args)
      union(*args)
      add_type
    end

    ### Collections

    def seq(elm_type = nil, name = nil)
      type(elm_type) if elm_type
      name(name)     if name

      type SeqType.new(*pop(:type, :name))
    end

    def seq!(*args)
      seq(*args)
      add_type
    end

    def set(elm_type = nil, name = nil)
      type(elm_type) if elm_type
      name(name)     if name

      type SetType.new(*pop(:type, :name))
    end

    def set!(*args)
      set(*args)
      add_type
    end

    ### Tuples and relations

    def tuple(heading = nil, name = nil)
      heading(heading) if heading
      name(name)       if name

      type TupleType.new(*pop(:heading, :name))
    end

    def tuple!(*args)
      tuple(*args)
      add_type
    end

    def relation(heading = nil, name = nil)
      heading(heading) if heading
      name(name)       if name

      type RelationType.new(*pop(:heading, :name))
    end

    def relation!(*args)
      relation(*args)
      add_type
    end

    ######################################################### Realm management

    def add_type
      realm.add_type(*pop(:type))
    end

  private

    def fail!(message)
      raise Error, message, caller
    end

    def push(who, what)
      @stacks[who] << what
      what
    end

    def pop(*whoes)
      whoes.map{|who| @stacks[who].pop }.compact
    end

    def pop_one(who)
      @stacks[who].pop
    end

    def pop_all(who)
      res, @stacks[who] = @stacks[who], []
      res
    end

  end # class TypeBuilder
end # module Qrb
