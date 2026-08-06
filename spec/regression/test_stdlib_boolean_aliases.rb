require 'spec_helper'

describe "The boolean aliases of the finitio/data stdlib" do
  let(:schema){
    Finitio.system <<~F
      @import finitio/data

      { t: TrueClass, f: FalseClass, tt: True, ff: False, b: Boolean }
    F
  }

  it 'dresses each alias with the value it stands for' do
    expect(
      schema.dress({t: true, f: false, tt: true, ff: false, b: true})
    ).to eql({t: true, f: false, tt: true, ff: false, b: true})
  end

  it 'refuses true where a false is expected' do
    expect(->(){
      schema.dress({t: true, f: true, tt: true, ff: false, b: true})
    }).to raise_error(Finitio::Error)
  end

  it 'refuses false where a true is expected' do
    expect(->(){
      schema.dress({t: false, f: false, tt: true, ff: false, b: true})
    }).to raise_error(Finitio::Error)
  end
end
