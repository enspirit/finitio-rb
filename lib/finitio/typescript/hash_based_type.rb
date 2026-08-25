module Finitio
  module HashBasedType

    def to_typescript(*args, &bl)
      defs = []

      attrs = heading.inject([]) do |ps,a|
        separator = a.required? ? ": " : "?: "
        type = if a.type.is_a?(UnionType)
          a.type.to_typescript
        ## TODO @llambeau @blambeau why do we assign default names to inline types anyway?
        elsif a.type.name && a.type.name[0] == '{'
          a.type.to_typescript
        else
          a.type.ts_name || a.type.to_typescript
        end
        ps + ["#{a.name}#{separator}#{type}"]
      end

      defs << "{ #{attrs.join(', ')} }" unless attrs.empty?

      if heading.allow_extra?
        extra = if heading.allow_extra.is_a?(Finitio::AliasType)
          heading.allow_extra.ts_name
        else
          heading.allow_extra.to_typescript(*args, &bl)
        end
        defs << "{ [key: string]: #{extra} }"
      end

      defs.join(' & ')
    end

  end # module HashBasedType
end # module UnionType
