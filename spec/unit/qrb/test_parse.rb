require 'spec_helper'
describe Qrb, "parse" do

  context 'with a string' do
    subject{
      Qrb.parse <<-EOF
        Posint = .Fixnum( i | i>=0 )
        Point  = { x: Posint, y: Posint }
      EOF
    }

    it{ should be_a(Qrb::System) }

    it 'should have the expected types' do
      subject["Posint"].should be_a(Qrb::SubType)
      subject["Point"].should be_a(Qrb::TupleType)
    end
  end

  context 'with a Path' do
    subject{
      Qrb.parse(Path.dir/"system.q")
    }

    it{ should be_a(Qrb::System) }

    it 'should have the expected types' do
      subject["Posint"].should be_a(Qrb::SubType)
    end
  end

end
