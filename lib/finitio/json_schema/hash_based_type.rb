module Finitio
  module HashBasedType

    def to_json_schema(*args, &bl)
      if type = metadata[:jsonSchemaType]
        return { type: type }
      end

      base = {
        type: "object"
      }
      unless heading.empty?
        base[:properties] = heading.inject({}){|ps,a|
          ps.merge(a.name => a.to_json_schema(*args, &bl))
        }
      end
      unless (reqs = heading.select{|a| a.required? }).empty?
        base[:required] = reqs.map{|a| a.name }
      end
      additional = if heading.allow_extra?
        heading.allow_extra.to_json_schema(*args, &bl)
      else
        false
      end
      base[:additionalProperties] = additional if additional
      base
    end

  end # module HashBasedType
end # module UnionType
