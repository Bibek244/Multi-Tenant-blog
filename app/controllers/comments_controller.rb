class CommentsController < ApplicationController

  def create
    @comment = Comment.create( comment_params.merge(user_id: params[:user_id], post_id: params[:post_id]))
    if @comment.save
      redirect_to organization_post_path(id: params[:post_id])
    end
  end

  def comment_params
  params.require(:comment).permit(:body)
  end
end
