require 'spec_helper'
describe Finitio, "parse" do

  context 'with a string' do
    subject{
      Finitio.parse <<-EOF
        Posint = .Integer( i | i>=0 )
        Point  = { x: Posint, y: Posint }
      EOF
    }

    it{ should be_a(Finitio::Syntax::System) }
  end

  context 'with a Path' do
    subject{
      Finitio.parse(Path.dir/"system.fio")
    }

    it{ should be_a(Finitio::Syntax::System) }
  end

end
