require 'spec_helper'
describe Finitio, "stdlib memoization" do

  describe "is_stdlib_source?" do

    it 'says false when source code' do
      expect(Finitio.is_stdlib_source?(".String")).to be_falsy
    end

    it 'says false when a source file' do
      expect(Finitio.is_stdlib_source?(Path.dir/"system.fio")).to be_falsy
    end

    it 'says true when a stdlib file' do
      source = Path.dir.parent.parent/"lib/finitio/stdlib/finitio/data.fio"
      expect(source).to be_file
      expect(Finitio.is_stdlib_source?(source)).to be_truthy
    end

  end

end
