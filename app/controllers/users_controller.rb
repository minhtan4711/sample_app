class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @pagy, @users = pagy(
      User.all,
      page: params[:page],
      items: Settings.paginate.per_page_10
    )
  end

  def show
    @user = User.find_by id: params[:id]
    if @user
      @pagy, @microposts = pagy(
      @user.microposts,
      page: params[:page],
      items: Settings.paginate.per_page_10
      )
    else
      flash[:danger] = t ".not_found"
      redirect_to root_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = t(".check_email")
      redirect_to root_url
    else
      flash[:danger] = t(".error")
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t(".success")
      redirect_to @user
    else
      flash[:danger] = t(".error")
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t(".success")
    else
      flash[:danger] = t(".error")
    end
    redirect_to users_path
  end

  private
  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t(".not_found")
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit User::USER_ATTRIBUTES
  end

  def correct_user
    return if current_user? @user
    flash[:danger] = t(".not_correct")
    redirect_to root_path
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
