class CommentsController < ApplicationController
  before_action :authenticate_user!

	def create
		@micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      @micropost.create_notification_comment!(current_user, @comment.id)
    	flash[:notice] = 'コメントを投稿しました。'
      redirect_to @micropost
    else
      flash[:error] = 'コメント投稿に失敗しました。'
      redirect_to @micropost
    end
	end

  private
  
	  def comment_params
	    params.require(:comment).permit(:content)
	  end
	
end