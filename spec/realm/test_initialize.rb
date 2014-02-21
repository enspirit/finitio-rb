require 'spec_helper'
module Qrb
  describe Realm, "initialize" do

    subject{ Realm.new }

    it{ should be_a(Realm) }

  end
end
