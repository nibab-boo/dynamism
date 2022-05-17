require 'rails_helper'

RSpec.describe "blogs response", type: :request do
  describe "GET /index" do
    context "authenticated user" do
      
      context "on test mode" do
        let!(:user) { create :user_with_blogs, :with_domain }
        
        context "with no-referrer" do
          before { get '/api/v1/blogs', headers: { 'X-User-Email': user.email, 'X-User-Token': user.authentication_token, 'Content-Type': 'application/json', "referrerPolicy": 'origin-when-cross-origin'} }
          
          it "should be unauthorized" do
            expect(response).to have_http_status(:unauthorized)
          end

          it 'returns error message' do
            expect(json).to eq({"error"=>"Please, provide referrerPolicy. Check http://www.example.com/profile for your api information."})
          end
        end

        context "from localhost" do
          before { get '/api/v1/blogs', headers: { 'X-User-Email': user.email, 'X-User-Token': user.authentication_token, 'Content-Type': 'application/json', "Referer": 'localhost:3001'} }

          it "should be successful" do
            expect(response).to have_http_status(:success)
          end
          
          it "blogs belong to current_user" do
            expect(assigns(:blogs)).to match_array(user.blogs)
          end

          it 'returns all blogs' do
            expect(json.length).to eq(2)
          end
        end

        context "from production" do
          before { get '/api/v1/blogs', headers: { 'X-User-Email': user.email, 'X-User-Token': user.authentication_token, 'Content-Type': 'application/json', "Referer": user.domain} }

          it "should be success" do   
            expect(response).to have_http_status(:success)
          end
          
          it "blogs belong to current_user" do
            expect(assigns(:blogs)).to match_array(user.blogs)
          end

          it "returns all blogs" do
            expect(json.length).to eq(2)
          end
        end

        context "from attackers" do
          before { get '/api/v1/blogs', headers: { 'X-User-Email': user.email, 'X-User-Token': user.authentication_token, 'Content-Type': 'application/json', "Referer": "www.google.com"} }
          
          it "should be unauthorized" do
            expect(response).to have_http_status(:unauthorized)
          end

          it 'returns error message' do
            expect(json).to eq({"error"=>"www.google.com is not the correct url for test. Please, try using local server ( Eg. localhost:3000 )."})
          end
        end
      end
      
      context "on production mode" do
        let!(:user) { create :user_with_blogs, :with_domain, :production }

        context "with no-referrer" do
          before { get '/api/v1/blogs', headers: { 'X-User-Email': user.email, 'X-User-Token': user.authentication_token, 'Content-Type': 'application/json', "referrerPolicy": 'origin-when-cross-origin'} }
          
          it "should be unauthorized" do
            expect(response).to have_http_status(:unauthorized)
          end

          it 'returns error message' do
            expect(json).to eq({"error"=>"Please, provide referrerPolicy. Check http://www.example.com/profile for your api information."})
          end
        end

        context "from localhost" do
          before { get '/api/v1/blogs', headers: { 'X-User-Email': user.email, 'X-User-Token': user.authentication_token, 'Content-Type': 'application/json', "Referer": 'localhost:3001'} }
          
          it "should be unauthorized" do
            expect(response).to have_http_status(:unauthorized)
          end

          it 'returns error message' do
            expect(json).to eq({"error"=>"localhost:3001 is not the correct domain of the user."})
          end
        end

        context "from production" do
          before { get '/api/v1/blogs', headers: { 'X-User-Email': user.email, 'X-User-Token': user.authentication_token, 'Content-Type': 'application/json', "Referer": user.domain} }
          
          it "should be success" do
            expect(response).to have_http_status(:success)
          end
  
          it "blogs belong to current_user" do
            expect(assigns(:blogs)).to match_array(user.blogs)
          end

          it 'returns all blogs' do
            expect(json.length).to eq(2)
          end
        end

        context "from attackers" do
          before { get '/api/v1/blogs', headers: { 'X-User-Email': user.email, 'X-User-Token': user.authentication_token, 'Content-Type': 'application/json', "Referer": "www.random.com"} }
          
          it "should be unauthorized" do
            expect(response).to have_http_status(:unauthorized)
          end

          it 'returns error message' do
            expect(json).to eq({"error"=>"www.random.com is not the correct domain of the user."})
          end
        end
      end
    end

    context "unauthenticated user" do
      before do
        user = create :user_with_blogs, :with_domain  
        get '/api/v1/blogs', headers: {'Content-Type': 'application/json', "Referer": user.domain}
      end

      it "returns unauthorized user" do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns error message' do
        expect(json).to eq({"error"=>"You need to sign in or sign up before continuing."})
      end
    end
  end
end