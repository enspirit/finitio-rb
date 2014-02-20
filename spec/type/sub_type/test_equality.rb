require 'spec_helper'
module Qrb
  describe SubType, "equality" do

    let(:c1){ ->(i){ i>0   } }
    let(:c2){ ->(i){ i<255 } }

    let(:type) { SubType.new("int1", intType, default: c1)      }
    let(:type2){ SubType.new("int2", intType, default: c1)      }
    let(:type3){ SubType.new("int3", intType, another_name: c1) }
    let(:type4){ SubType.new("int4", intType, default: c2)      }
    let(:type5){ SubType.new("int5", floatType, default: c1)    }

    it 'should apply structural equality' do
      (type == type2).should be_true
      (type == type3).should be_true
    end

    it 'should apply distinguish different types' do
      (type == type4).should be_false
      (type == type5).should be_false
    end

    it 'should be a total function, with nil for non types' do
      (type == 12).should be_nil
    end

    it 'should implement hash accordingly' do
      (type.hash == type2.hash).should be_true
      (type.hash == type3.hash).should be_true
    end

  end
end
