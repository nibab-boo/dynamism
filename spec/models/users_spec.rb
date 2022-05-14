require 'rails_helper'

RSpec.describe User, type: :model do
  # initialize
  let (:user) { build :user }
  describe "#initialize" do
    context "when valid" do
      it "returns a valid user" do
        expect(user.valid?).to eq(true)
      end
      it "generates API key" do
        user.save
        expect(!!(user.authentication_token)).to eq(true)
      end
      it "default API mode is test" do
        expect(user.test).to eq(true)
      end
    end

    context "when invalid" do
      context "without email" do
        before { user.email = nil }
        it "returns invalid user" do
          expect(user.valid?).to eq(false)
        end
        
        it "returns error message" do
          user.valid?
          expect(user.errors.messages).to eq({email: ["can't be blank"]})
        end
      end

      context "without password" do
        before { user.password = nil }
        it "returns invalid user" do
          expect(user.valid?).to eq(false)
        end
        
        it "returns error message" do
          user.valid?
          expect(user.errors.messages).to eq({password: ["can't be blank"]})
        end
      end

    end
  end


  # when invalid
      # no email
      # no password

end