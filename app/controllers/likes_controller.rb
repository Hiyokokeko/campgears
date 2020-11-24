class LikesController < ApplicationController
  before_action :logged_in_user

  def create
    @page = Page.find(params[:page_id])
    return if current_user.like?(@page)

    current_user.like(@page)
    @page.reload
    respond_to do |format|
      format.html { redirect_to request.referer || root_url }
      format.js
    end
  end

  def destroy
    @page = Page.find(params[:page_id])
    return unless current_user.like?(@page)

    current_user.unlike(@page)
    @page.reload
    respond_to do |format|
      format.html { redirect_to request.referer || root_url }
      format.js
    end
  end
end
