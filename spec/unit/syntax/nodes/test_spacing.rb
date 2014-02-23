require 'spec_helper'
module Qrb
  describe Syntax, "spacing" do

    subject{
      Syntax.parse(input, root: "spacing")
    }

    [
      '    ',
      "\n",
      "  \t\n",
      "   # foo\n"
    ].each do |source|
      context "when `#{source}`" do
        let(:input){ source }

        it 'should parse' do
          subject.should eq(source)
        end
      end
    end

  end
end
