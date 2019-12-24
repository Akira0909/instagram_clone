class MicropostsController < ApplicationController
	before_action :authenticate_user!, only: [:create, :destroy]
  before_action :correct_user, only: :destroy
	
	def index
	  @user = current_user
	  @comment = Comment.new
	end
	
	def new
	  @micropost = current_user.microposts.build if user_signed_in?
	end
	
	def show
	  @micropost = Micropost.find(params[:id])
	  @user = @micropost.user
	  @comments = @micropost.comments
	  @comment = Comment.new
	  @likes_count = Like.where(micropost_id: @micropost.id).count 
	end
	 
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:notice] = "投稿しました。"
      redirect_to @micropost
    else
      @feed_items = []
      render 'microposts/new'
    end
  end

  def destroy
    @micropost.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to request.referrer || root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end
    
    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
	
end