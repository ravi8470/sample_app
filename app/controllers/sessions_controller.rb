class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end
  def destroy
    sign_out
    flash.now[:signedoutnotif] = "You have successfully signed out."#how to make this work
    redirect_to root_url

  end
end
