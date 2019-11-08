module Finitio
  module HashBasedType

    def to_json_schema(*args, &bl)
      base = {
        type: "object"
      }
      unless heading.empty?
        base[:properties] = heading.inject({}){|ps,a|
            ps.merge(a.name => a.type.to_json_schema(*args, &bl))
        }
      end
      unless (reqs = heading.select{|a| a.required? }).empty?
        base[:required] = reqs.map{|a| a.name }
      end
      base[:additionalProperties] = if heading.allow_extra?
        heading.allow_extra.to_json_schema(*args, &bl)
      else
        false
      end
      base
    end

  end # module HashBasedType
end # module UnionType
