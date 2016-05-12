class UsersController < ApplicationController
  
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Thank you for signing up! You are now logged in."
      redirect_to "/"
    else
      render :action => 'new'
    end
  end
  
  def permitted_params
    params.permit!
  end
  #def user_params
  #  params.require(:user).permit(:username, :email, :password_hash, :password_salt, :password, :password_confirmation, :salt, :encrypted_password)
  #end
end