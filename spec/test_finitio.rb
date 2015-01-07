require 'spec_helper'
describe Finitio do

  it "should have a version number" do
    expect(Finitio.const_defined?(:VERSION)).to eq(true)
  end

end
