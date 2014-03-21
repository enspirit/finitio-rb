require 'spec_helper'
describe Finitio do

  it "should have a version number" do
    Finitio.const_defined?(:VERSION).should be_true
  end

end
