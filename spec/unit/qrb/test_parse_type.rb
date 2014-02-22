require 'spec_helper'
describe Qrb, "parse_type" do

  subject{
    Qrb.parse_type <<-EOF
      { x: .Fixnum, y: .Float }
    EOF
  }

  it{ should be_a(Qrb::TupleType) }

end
