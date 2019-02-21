require 'spec_helper'
module Finitio
  describe System, "check_and_warn" do

    before {
      Finitio.stdlib_path(Path.dir)
    }

    subject{
      Finitio.system(Path.dir/"fixtures/with-duplicates.fio").check_and_warn(logger)
    }

    let(:logger){
      TestLogger.new
    }

    it {
      should be_a(Finitio::System)
    }

    it 'detects duplicate types as expected' do
      subject
      expect(logger.infos).to eql([
        "Duplicate type def `NilClass`",
        "Duplicate type def `Posint`"
      ])
    end

    it 'detects type erasures as expected' do
      subject
      expect(logger.warns).to eql([
        "Type erasure `Negint`",
      ])
    end

    class TestLogger

      def initialize
        @warns = []
        @infos = []
      end
      attr_reader :warns, :infos

      def warn(msg)
        @warns << msg
      end

      def info(msg)
        @infos << msg
      end

    end

  end
end
