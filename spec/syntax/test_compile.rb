require 'spec_helper'
module Qrb
  describe Syntax, '.compile' do

    subject do
      Syntax.compile <<-EOF
        {
          name: .String,
          color: { red: .Integer, green: .Integer, blue: .Integer },
          sex: .String( s | s =~ /^M|F$/ )
        }
      EOF
    end

    it{ should be_a(Type) }

  end
end
