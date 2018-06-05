class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = 'Login Successful'
      redirect_to user_path(user)
    else
      flash.now[:danger] = 'Login Failed! Username and or Password incorrect, please check credentials and try again.'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Logout Successful'
    redirect_to root_path
  end
end
