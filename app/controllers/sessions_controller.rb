class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      handle_login user
    else
      flash.now[:danger] = t ".error"
      render "new"
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = t ".success"
    redirect_to root_path
  end

  private
  def handle_login user
    if user.activated?
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      flash[:success] = t(".success")
      redirect_back_or user
    else
      flash[:warning] = t(".account_not_activated")
      redirect_to root_path
  end

end
