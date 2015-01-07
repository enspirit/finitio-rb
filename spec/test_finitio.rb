require 'spec_helper'
describe Finitio do

  it "should have a version number" do
    expect(Finitio.const_defined?(:VERSION)).to be_true
  end

end
