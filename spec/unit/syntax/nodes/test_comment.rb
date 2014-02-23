require 'spec_helper'
module Qrb
  describe Syntax, "comment" do

    subject{
      Syntax.parse(input, root: "comment")
    }

    [
      '#',
      "#\n",
      "# \n",
      '# foo bar',
      "# foo bar\n",
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
