class LikesController < ApplicationController
  before_action :authenticate_user!
	
	def create
    micropost = Micropost.find(params[:micropost_id])
    current_user.like(micropost)
    micropost.create_notification_like!(current_user)
    flash[:notice] = 'お気に入りに登録しました。'
    redirect_back(fallback_location: microposts_url)
	end

  def destroy
    micropost = Micropost.find(params[:micropost_id])
    current_user.unlike(micropost)
    flash[:notice] = 'お気に入り登録を解除しました。'
    redirect_back(fallback_location: microposts_url)
  end
	
end