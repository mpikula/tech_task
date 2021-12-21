class UsersController < ApplicationController 
    before_action :authorized, only: [:show]

    def show
        @user = User.find_by(id: params[:id])
    end
end