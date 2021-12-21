require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "GET /login" do
    it 'opens login page successfuly' do
      get login_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Password')
      expect(response.body).to include('Username')
    end
  end

  describe "POST /create" do    
    it 'increases login attempts after failed login' do
      user = create(:user)
      expect(user.login_attempts).to eq(0)
      post sessions_path(username: 'test123', password: 'test')
      user.reload
      expect(user.login_attempts).to eq(1)
      expect(response).to redirect_to(login_path)
      follow_redirect!
      expect(response.body).to include('Login failed. Used 1 out of 3')
    end

    it 'resets login attempts after successful login' do
      user = create(:user, login_attempts: 2)
      expect(user.login_attempts).to eq(2)
      post sessions_path(username: 'test123', password: 'test123')
      user.reload
      expect(user.login_attempts).to eq(0)
      follow_redirect!
      expect(response.body).to include('Welcome to your page test123')
    end

    it 'redirects to login page with error message when user enters wrong username' do
      user = create(:user)
      post sessions_path(username: 'wrong_username', password: 'test123')
      expect(response).to redirect_to(login_path)
      follow_redirect!
      expect(response.body).to include('Login failed.')
    end

    it 'redirects to login page with error message when user has 3 or more failed login attempts' do
      user = create(:user, login_attempts: 3, account_locked: true)
      post sessions_path(username: 'test123', password: 'test')
      expect(response).to redirect_to(login_path)
      follow_redirect!
      expect(response.body).to include('Your account have been locked. Please contact system administrator.')
    end
  end

  describe "DELETE /destroy" do 
    it 'log outs users' do
      user = create(:user)
      post sessions_path(username: 'test123', password: 'test123')
      follow_redirect!
      delete sessions_path(user.id)
      expect(response).to redirect_to(login_path)
      follow_redirect!
      expect(response.body).to include('You have been logged out') 
    end
  end
end
