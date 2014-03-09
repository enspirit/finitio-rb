module Qrb
  module DataType

    def dress(value, handler = DressHelper.new)
      ad_type.dress(value, handler)
    end

    def contract(name, infotype)
      dresser   = method(name)
      undresser = instance_method(:"to_#{name}")
      ad_contracts[name] = [
        Qrb.type(infotype),
        dresser,
        ->(d){ undresser.bind(d).call }
      ]
    end

  private

    def ad_type
      @ad_type ||= Qrb.adt(self, ad_contracts)
    end

    def ad_contracts
      @ad_contracts ||= {}
    end

  end # module DataType
end # module Qrb
