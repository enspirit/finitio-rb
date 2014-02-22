module Qrb
  module DataType

    def up(value, handler = UpHandler.new)
      ad_type.up(value, handler)
    end

    def contract(name, infotype)
      ad_contracts[name] = [ Qrb.type(infotype) , self ]
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
