class StaticPagesController < ApplicationController
  
  def home
    if user_signed_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @user = @micropost.user
    end 
  end
  
  def terms
  end
  
end
