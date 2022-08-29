class StaticPagesController < ApplicationController
  def home
    return unless logged_in?
      @micropost = current_user.microposts.build
      @pagy, @feed_items = pagy(
        current_user.feed,
        page: params[:page],
        items: Settings.paginate.per_page_10
      )
  end

  def help; end

  def about; end

  def contact; end
end
