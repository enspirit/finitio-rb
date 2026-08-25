module Finitio
  module Typescript
    describe "System" do
      let(:system){ System.new }

      before do
        system.add_type(intType)
        system.add_type(byte)
        system.add_type(namespacedStringType)
      end

      # it 'works as expected' do
      #   expected = <<~TS.strip
      #     export type intType = number
      #     export type Byte = number
      #     export type NamespaceString = string
      #   TS
      #   expect(system.to_typescript).to eql(expected)
      # end

      it 'converts unsafe type names to safe typescript type names' do
        system = Finitio.system(<<~FIO)
          @import finitio/data

          UUID = String(s | s s.strip.size > 0)
          URL = String

          JSONApi.Links = {
            self: URL
            ...: URL
          }

          JSONApi.Entity<T> = {
            id: UUID
            type: String
            attributes: T
            links: JSONApi.Links
          }

          JSONApi.Relationship<T> = {
            links : Links
            data  : JSONApi.Entity<T>
          }

          Person.Attributes.Full = {
            name: String
            dob: DateTime|Nil
            inline: {
              meta: String
            }
          }
          Person = JSONApi.Entity<Person.Attributes.Full>
        FIO

        expected = <<~TS.strip
          export type UUID = String
          export type URL = String
          export type JSONApiLinks = { self: URL } & { [key: string]: URL }
          export type JSONApiEntity<T> = { id: UUID, type: String, attributes: T, links: JSONApiLinks }
          export type JSONApiRelationship<T> = { links: Links, data: JSONApiEntity<T> }
          export type PersonAttributesFull = { name: String, dob: DateTime|Nil, inline: { meta: String } }
          export type Person = JSONApiEntity<PersonAttributesFull>
        TS
        expect(system.to_typescript).to eql(expected)
      end
    end
  end
end
