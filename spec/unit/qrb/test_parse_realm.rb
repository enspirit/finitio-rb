require 'spec_helper'
describe Qrb, "parse_realm" do

  subject{
    Qrb.parse_realm <<-EOF
      Posint = .Fixnum( i | i>=0 )
      Point  = { x: Posint, y: Posint }
    EOF
  }

  it{ should be_a(Qrb::Realm) }

  it 'should have the expected types' do
    subject["Posint"].should be_a(Qrb::SubType)
    subject["Point"].should be_a(Qrb::TupleType)
  end

end
