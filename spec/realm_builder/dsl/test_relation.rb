require 'spec_helper'
module Qrb
  describe RealmBuilder, "DSL#relation" do

    let(:builder){ RealmBuilder.new }

    let(:heading){
      Heading.new([ Attribute.new(:a, intType) ])
    }

    shared_examples_for "The Relation[a: Int] type" do

      it{ should be_a(RelationType) }

      it 'should have the correct heading' do
        subject.heading.should eq(heading)
      end
    end

    describe 'the normal version' do

      before do
        subject
        # it should not be saved
        builder.realm[subject.name].should be_nil
      end

      context 'when used with the standard signature' do
        subject{
          builder.relation(heading, "MyRelation")
        }

        it_should_behave_like "The Relation[a: Int] type"

        it 'should have the correct name' do
          subject.name.should eq("MyRelation")
        end
      end

      context 'when used with a hash and ruby classes' do
        subject{
          builder.relation(a: Integer)
        }

        it_should_behave_like "The Relation[a: Int] type"

        it 'should have the correct name' do
          subject.name.should eq("{{a: Integer}}")
        end
      end

      context 'when used with a hash and a name' do
        subject{
          builder.relation({a: Integer}, "MyRelation")
        }

        it_should_behave_like "The Relation[a: Int] type"

        it 'should have the correct name' do
          subject.name.should eq("MyRelation")
        end
      end

      context 'when used with a hash and types' do
        subject{
          builder.relation(a: intType)
        }

        it_should_behave_like "The Relation[a: Int] type"

        it 'should have the correct name' do
          subject.name.should eq("{{a: intType}}")
        end
      end
    end

    describe 'the ! version' do
      subject{
        builder.relation!(a: Integer)
      }

      it_should_behave_like "The Relation[a: Int] type"

      it 'should be saved' do
        subject
        builder.realm['{{a: Integer}}'].should be(subject)
      end
    end

  end
end
