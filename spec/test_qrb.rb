require 'spec_helper'
describe Qrb do

  it "should have a version number" do
    Qrb.const_defined?(:VERSION).should be_true
  end

end
