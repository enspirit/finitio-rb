require 'spec_helper'
describe "Finitio definition files" do

  Finitio.definition_files('Finitio').each do |file|
    file = Path(file)

    describe "Finitio/#{file.basename.rm_ext}" do

      it 'should parse' do
        Finitio.parse(file.read).should be_a(Finitio::System)
      end
    end
  end

end