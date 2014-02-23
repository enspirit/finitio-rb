require 'spec_helper'
describe "Q definition files" do

  Qrb.definition_files('Q').each do |file|
    file = Path(file)

    describe "Q/#{file.basename.rm_ext}" do

      it 'should parse' do
        Qrb.parse_realm(file.read).should be_a(Qrb::Realm)
      end
    end
  end

end