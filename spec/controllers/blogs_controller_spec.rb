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
      context "Valid params" do
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

      context "Invalid params" do
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

    describe "#edit" do
      context "Valid Id" do
        before do
          blog.save
          get :edit, params: { id: blog }
        end

        it "returns successful" do
          expect(response).to be_successful
        end
        
        it "redirects to index" do
          expect(response).to render_template('blogs/index')
        end
        
        it "sends a blog with given id" do
          expect(assigns(:blog).id).to be(blog.id)
        end
        
        it "sends a activerecord relation array of current user" do
          Array.new(3) { create(:blog, user: user) } 
          expect(assigns(:blogs)).to match_array(user.blogs.order(id: :asc))
        end
      end
      
      context "Invalid Id" do
        let(:action) { get :edit, params: { id: "random" } }

        it "raises exception: RecordNotFound" do
          expect{action}.to raise_exception(ActiveRecord::RecordNotFound)
        end
      end
    end

    describe "update" do
      context "Valid params" do
        before do
          blog.save
          put :update, params: { blog: attributes_for(:blog, title: "New Title"), id: blog }
        end 

        it "updates blog" do
          blog.reload
          expect(blog.title).to eq("New Title")
        end

        it "redirects to index" do
          expect(response).to redirect_to(blogs_path)
        end

        it "current user is the owner" do
          expect(assigns(:blog).user.id).to eq(user.id)
        end
      end

      context "Invalid params" do
        before do
          blog.save
          put :update, params: { blog: attributes_for(:blog, title: nil), id: blog}
        end
 
        it "doesnot update blog" do
          blog.reload
          expect(blog.title).to eq("Title")
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