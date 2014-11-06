class CommentsController < ApplicationController

  def create
  @commentable = find_commentable
  @comment     = @commentable.comments.build(comments_params)

  if @comment.save
    @commentable.send_comment(current_user)
    flash[:notice] = "Successfully created comment."
    redirect_to :back
  else
    flash[:notice] = "Comment not created"
    redirect_to :back
  end
end

  def comments_params
    params.require(:comment).permit(:content, :user_id)
  end

private

def find_commentable
  id = params[:comment][:type].downcase + "_id"
  params[:comment][:type].constantize.find(params[id])
end


end
