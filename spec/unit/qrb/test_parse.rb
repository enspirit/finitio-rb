require 'spec_helper'
describe Finitio, "parse" do

  context 'with a string' do
    subject{
      Finitio.parse <<-EOF
        Posint = .Fixnum( i | i>=0 )
        Point  = { x: Posint, y: Posint }
      EOF
    }

    it{ should be_a(Finitio::System) }

    it 'should have the expected types' do
      subject["Posint"].should be_a(Finitio::SubType)
      subject["Point"].should be_a(Finitio::TupleType)
    end
  end

  context 'with a Path' do
    subject{
      Finitio.parse(Path.dir/"system.q")
    }

    it{ should be_a(Finitio::System) }

    it 'should have the expected types' do
      subject["Posint"].should be_a(Finitio::SubType)
    end
  end

end
