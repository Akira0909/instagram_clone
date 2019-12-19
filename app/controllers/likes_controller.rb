class LikesController < ApplicationController
	
	def create
    micropost = Micropost.find(params[:micropost_id])
    current_user.like(micropost)
    micropost.create_notification_like!(current_user)
    flash[:notice] = 'お気に入り登録をしました。'
    redirect_to root_url
	end

  def destroy
    micropost = Micropost.find(params[:micropost_id])
    current_user.unlike(micropost)
    flash[:notice] = 'お気に入り登録を解除しました。'
    redirect_to root_url
  end
	
end
