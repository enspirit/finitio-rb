require 'spec_helper'
describe Qrb do

  it "should have a version number" do
    Qrb.const_defined?(:VERSION).should be_true
  end

  it 'should have DSL methods' do
    t = Qrb.type(Fixnum){|i| i>=0 }
    t.should be_a(Qrb::SubType)
    t.up(12).should eq(12)
    ->{ t.up(-12) }.should raise_error(Qrb::UpError)
  end

end
