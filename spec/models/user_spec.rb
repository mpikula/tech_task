require 'rails_helper'

RSpec.describe User, type: :model do

  it 'is valid with valid attributes' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'is not valid without a username' do
    user = build(:user, username: nil)
    expect(user).to_not be_valid
  end

  it 'is not valid without a password_hash' do
    user = build(:user, password_hash: nil)
    expect(user).to_not be_valid      
  end

  it 'is encrypts password_hash' do
    require 'bcrypt'
    user = create(:user)
    expect(BCrypt::Password.new(user.password_hash)).to eq("test123")
  end

end