require 'spec_helper'
module Finitio
  module Typescript
    describe "A recursive type" do

      let(:system){
        ::Finitio.system <<-FIO
          Tree = {
            children : [Tree]
          }
        FIO
      }

      let(:type) {
        system['Tree']
      }

      xit 'works as expected' do
        expect(type.to_typescript).to eql({
          type: "object",
          properties: {
            children: {
              type: "array",
              items: {
                type: "object",
                properties: {
                  children: {
                    type: "array",
                    items: "object"
                  }
                },
                required: [
                  :children
                ],
                additionalProperties: false
              }
            }
          },
          required: [
            :children
          ],
          additionalProperties: false
        })
      end

    end
  end
end
