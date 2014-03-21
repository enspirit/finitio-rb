require 'spec_helper'
module Finitio
  describe SubType, "equality" do

    let(:c1){ ->(i){ i>0   } }
    let(:c2){ ->(i){ i<255 } }

    let(:type) { SubType.new(intType, default: c1)      }
    let(:type2){ SubType.new(intType, default: c1)      }
    let(:type3){ SubType.new(intType, another_name: c1) }
    let(:type4){ SubType.new(intType, default: c2)      }
    let(:type5){ SubType.new(floatType, default: c1)    }

    it 'should apply structural equality' do
      (type == type2).should be_true
      (type == type3).should be_true
    end

    it 'should apply distinguish different types' do
      (type == type4).should be_false
      (type == type5).should be_false
    end

    it 'should be a total function, with nil for non types' do
      (type == 12).should be_false
    end

    it 'should implement hash accordingly' do
      (type.hash == type2.hash).should be_true
      (type.hash == type3.hash).should be_true
    end

  end
end
