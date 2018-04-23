class UsersController < ApplicationController
    
    def destroy
        @user = User.find(params[:id])
        if @user.destroy
            redirect_to users_path
        end
    end
    
end
