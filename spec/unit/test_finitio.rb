require 'spec_helper'
describe Finitio do

  it "should have a version number" do
    Finitio.const_defined?(:VERSION).should be_true
  end

  it 'should have DSL methods' do
    t = Finitio.type(Fixnum){|i| i>=0 }
    t.should be_a(Finitio::SubType)
    t.dress(12).should eq(12)
    ->{ t.dress(-12) }.should raise_error(Finitio::TypeError)
  end

end
