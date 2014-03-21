require 'spec_helper'
module Finitio
  describe System, "initialize" do

    let(:system){ System.new }

    context 'for building a tuple type' do
      subject{
        system.tuple(r: Integer)
      }
      
      it{ should be_a(TupleType) }
    end

    context 'for building a sub type' do
      subject{
        system.subtype(Integer){|i| i>=0 }
      }

      it{ should be_a(SubType) }

      it 'should apply the constraint' do
        ->{
          subject.dress(-9)
        }.should raise_error(TypeError)
      end
    end

  end
end
