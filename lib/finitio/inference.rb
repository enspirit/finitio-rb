module Finitio
  class Inference

    def initialize(system, options = {})
      @system = system
      @options = options
    end
    attr_reader :system

    def call(input)
      infer_type(input)
    end

  private

    def infer_type(value)
      case value
      when Hash
        attrs = value.map{|k,v|
          Attribute.new(k.to_sym, infer_type(v))
        }
        heading = Heading.new(attrs)
        TupleType.new(heading)
      when Array
        infered = value.inject(nil){|sup, value|
          value_type = infer_type(value)
          sup.nil? ? value_type : sup.suppremum(value_type)
        }
        SeqType.new(infered.nil? ? ANY_TYPE : infered)
      else
        found = self.system.types.values.find{|t|
          try_dress(t, value)
        }
        found ? found : ANY_TYPE
      end
    end

    def try_dress(t, value)
      raise "Type expected, got #{t}" unless t.is_a?(Type)
      t.dress(value)
      true
    rescue Finitio::Error => ex
      #puts %Q{[#{ex.class}] #{ex.message}}
      nil
    rescue => ex
      puts %Q{[#{ex.class}] #{ex.message}\n#{ex.backtrace.join("\n")}}
      nil
    end

  end # class Inference
end # module Finitio
