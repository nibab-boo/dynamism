require 'rails_helper'

RSpec.describe BlogsController, type: :controller do
  let (:user) { create :user }
  let (:blog) { build(:blog, user: user)}

  context "User sign_in" do
    before { sign_in user }

    describe "#index" do
      before { get :index }
      it "returns successful" do
        expect(response).to be_successful
      end

      it "renders blogs/index" do
        expect(response).to render_template("blogs/index")
      end
      
      it "sends a new blog" do
        expect(assigns(:blog)).to be_a_new(Blog)
      end

      it "sends a activerecord relation array of current user" do
        # can be done
        # user = create(:user_with_blogs, email: "test2@test.com")
        # sign_in user
        Array.new(3) { create(:blog, user: user) } 
        expect(assigns(:blogs)).to match_array(user.blogs.order(id: :asc))
      end
    end
    
    describe "#create" do
      context "valid params" do
        before { post :create, params: { blog: attributes_for(:blog) }}

        it "creates blogs" do
          expect(assigns(:blog).id).to_not eq(nil)
        end

        it "redirects to index" do
          expect(response).to redirect_to(blogs_path)
        end

        it "current user is the owner" do
          expect(assigns(:blog).user.id).to eq(user.id)
        end
      end

      context "valid params" do
        before { post :create, params: { blog: attributes_for(:blog, title: "")} }
        
        it "returns invalid blog" do
          expect(assigns(:blog).id).to eq(nil)
        end

        it "returns error message" do
          expect(assigns(:blog).errors.messages).to eq({title: ["can't be blank"]})
        end

        it "renders index" do
          expect(response).to render_template('blogs/index');
        end

        it "sends a activerecord relation array of current user" do
          Array.new(3) { create(:blog, user: user) } 
          expect(assigns(:blogs)).to match_array(user.blogs.order(id: :asc))
        end
      end
    end

  end
end