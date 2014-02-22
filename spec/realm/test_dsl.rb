require 'spec_helper'
module Qrb
  describe Realm, "initialize" do

    let(:realm){ Realm.new }

    context 'for building a tuple type' do
      subject{
        realm.tuple(r: Integer)
      }
      
      it{ should be_a(TupleType) }
    end

  end
end
