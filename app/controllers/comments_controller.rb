class CommentsController < ApplicationController

  def create
    @commentable = find_commentable
    @comment = @commentable.comments.create(comment_params)
    if @comment.save
      redirect_to @commentable, notice: "comment was successfully created."
    else
      redirect_to @commentable, notice: "Error: Failed to create comment."
    end
  end

  def comment_params
  params.require(:comment).permit(:body)
  end
end
