require 'spec_helper'
describe Finitio, "system" do

  context 'with a string' do
    subject{
      Finitio.system <<-EOF
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
      Finitio.system(Path.dir/"system.fio")
    }

    it{ should be_a(Finitio::System) }

    it 'should have the expected types' do
      subject["Posint"].should be_a(Finitio::SubType)
    end
  end

end
