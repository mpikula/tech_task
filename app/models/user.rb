class User < ApplicationRecord
    require 'bcrypt'
    before_save :encrypt_password, if: :password_hash_changed?
    validates :username, presence: true, uniqueness: true
    validates :password_hash, presence: true

    def authenticate(pass)
        BCrypt::Password.new(password_hash) == pass
    end

    def account_locked? 
        self.account_locked
    end

    def increment_login_attempts
        self.login_attempts += 1
        self.account_locked = true if self.login_attempts > 2
        self.save
    end

    def reset_login_attempts
        self.login_attempts = 0
        self.save
    end

    private

    def encrypt_password
        self.password_hash = BCrypt::Password.create(password_hash)
    end
end
