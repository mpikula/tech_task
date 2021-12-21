require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /show" do
    it "redirects to login page if user is not logged in" do
      user = create(:user)
      get user_path(user.id)
      expect(response).to redirect_to(login_path)
    end
    
    it "displays user page if user is logged in" do
      user = create(:user)
      post sessions_path(username: 'test123', password: 'test123')
      get user_path(user.id)
      expect(response.body).to include('Welcome to your page test123')
    end
  end
end