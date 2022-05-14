require 'rails_helper'

RSpec.describe Blog, type: :model do
  let(:blog) { build :blog }

  describe '#initialize' do
    
    context "when valid" do
      it 'returns a valid Task' do
        expect(blog.valid?).to eq(true)
      end
    end

    context "Invalid Task" do
      context "without title" do
        before { blog.title = nil }
        it "returns invalid task" do
          expect(blog.valid?).to eq(false)
        end

        it "returns error message" do
          blog.valid?
          expect(blog.errors.messages).to eq({title: ["can't be blank"]})
        end
      end

      context "without description" do
        before { blog.description = nil }
        it "returns invalid task" do
          expect(blog.valid?).to eq(false)
        end

        it "returns error message" do
          blog.valid?
          expect(blog.errors.messages).to eq({description: ["can't be blank"]})
        end
      end
    end

  end
end