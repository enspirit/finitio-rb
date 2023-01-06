require 'spec_helper'

describe "Dress on a recursive type" do
  let(:schema){
    Finitio.system <<~F
      Tree = {
        children: [Tree]
      }
      Tree
    F
  }

  it 'works on an empty tree' do
    expect(->(){
      schema.dress({children: []})
    }).not_to raise_error
  end

  it 'works on a non empty tree' do
    expect(->(){
      schema.dress({
        children: [{
          children: [{
            children: [{
              children: []
            }]
          }]
        }]
      })
    }).not_to raise_error
  end

  it 'detects deep error' do
    expect(->(){
      schema.dress({
        children: [{
          children: [{
            children: [{
              children: [{
                children: [{
                  children: [{
                    unrecognized: true,
                    children: []
                  }]
                }]
              }]
            }]
          }]
        }]
      })
    }).to raise_error(Finitio::Error)
  end
end
