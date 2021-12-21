class SessionsController < ApplicationController

    def new 
        redirect_to user_path(current_user) if logged_in?
    end

    def create
        @user = User.find_by(username: params[:username])

        if @user&.account_locked?
            redirect_to login_path, alert: 'Your account have been locked. Please contact system administrator.'
        elsif @user&.authenticate(params[:password])
            session[:user_id] = @user.id
            @user.reset_login_attempts
            redirect_to user_path(@user)
        else
          error_message = "Login failed."
          if @user
            @user.increment_login_attempts
            error_message += " Used #{@user.login_attempts} out of 3"
          end
          redirect_to login_path, alert: error_message
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to login_path, alert: "You have been logged out"
    end
end