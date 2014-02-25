module Qrb
  module DataType

    def dress(value, handler = DressHelper.new)
      ad_type.dress(value, handler)
    end

    def contract(name, infotype)
      ad_contracts[name] = [ Qrb.type(infotype) , method(name) ]
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
