require 'spec_helper'
module Finitio
  describe Syntax, '.compile' do

    let(:source){
      <<-EOF.strip
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
