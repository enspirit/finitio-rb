require 'spec_helper'
module Finitio
  module JsonSchema
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

      it 'works as expected' do
        expect(type.to_json_schema).to eql({
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
