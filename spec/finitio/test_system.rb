require 'spec_helper'
describe Finitio, "system" do

  context 'with a string' do
    subject{
      Finitio.system <<-EOF
        Posint = .Integer( i | i>=0 )
        Point  = { x: Posint, y: Posint }
      EOF
    }

    it{ should be_a(Finitio::System) }

    it 'should have the expected types' do
      expect(subject["Posint"]).to be_a(Finitio::SubType)
      expect(subject["Point"]).to be_a(Finitio::TupleType)
    end
  end

  context 'with a Path' do
    subject{
      Finitio.system(Path.dir/"system.fio")
    }

    it{ should be_a(Finitio::System) }

    it 'should have the expected types' do
      expect(subject["Posint"]).to be_a(Finitio::SubType)
    end
  end

end
