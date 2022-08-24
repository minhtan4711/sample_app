class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build micropost_params
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = t ".success"
      redirect_to root_path
    else
      flash[:danger] = t ".error"
      @pagy, @feed_items = pagy(
        current_user.feed,
        page: params[:page],
        items: Settings.paginate.per_page_10
      )
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".error"
    end
    redirect_to request.referrer || root_path
  end

  private
  def micropost_params
    params.require(:micropost).permit :content, :image
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    return if @micropost
    flash[:danger] = t ".find_micropost_fail"
    redirect_to root_path if @micropost.nil?
  end
end
