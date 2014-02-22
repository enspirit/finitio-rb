require 'spec_helper'
module Qrb
  describe Syntax, '.compile' do

    let(:source){
      <<-EOF
        {
          name: .String,
          color: { red: .Integer, green: .Integer, blue: .Integer },
          sex: .String( s | s =~ /^M|F$/ )
        }
      EOF
    }

    subject do
      Syntax.compile_type(source)
    end

    it{ should be_a(Type) }

  end
end
