class CommentsController < ApplicationController
  before_action :set_page

  def create
    @comment = @page.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    render 'pages/show'
  end

  def destroy
    @comment = current_user.comments.find_by(id: params[:id])
    @comment.destroy
    render 'pages/show'
  end

  private

  def set_page
    @page = Page.find(params[:page_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :page_id, :user_id)
  end
end
