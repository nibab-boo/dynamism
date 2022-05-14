require 'rails_helper'

RSpec.describe BlogsController, type: :controller do
  let (:user) { create :user }
  let (:blog) { build(:blog, user: user)}\

  context "User sign_in" do
    before { sign_in user }

    describe "#index" do
      it "renders index" do
        get :index
        expect(response).to be_successful
      end
      
    end
  end
end