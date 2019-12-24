class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :picture_edit,
    :picture_update, :picture_delete, :following, :followers, :likes]
  before_action :correct_user, only: [:picture_update, :picture_delete]
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts
  end
  
  def picture_edit
    @user = User.find(params[:id])
  end
  
  def picture_update
    @user = User.find(params[:id])
    
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}",image.read)
    end
    
    if @user.save
      flash[:notice] = "ユーザー画像を更新しました。"
      redirect_to @user
    else
      @feed_items = []
      render 'users/picture_update'
    end
  end
  
  def picture_delete
    @user = User.find(params[:id])
    @user.image_name = "default_image.jpg"
    @user.save
    flash[:notice] = "ユーザー画像を削除しました。"
    redirect_to @user
  end
  
  def following
    @title = "フォロー"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def likes
    @title = "お気に入りの投稿"
    @user = User.find(params[:id])
    @likeposts = @user.likeposts.page(params[:page])
    @comment = Comment.new
    render 'show_like'
  end
  
  private
  
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
  
end