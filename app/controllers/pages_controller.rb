class PagesController < ApplicationController
  before_action :logged_in_user, only: %i[new edit create update destroy]
  before_action :correct_user,   only: %i[edit update destroy]

  # 投稿一覧/root
  def index
  end

  def show
  end

  def new
    if logged_in?
      @page = current_user.pages.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @user = User.find(current_user.id)
    else
      redirect_to root_url
    end
  end

  def create
    @page = current_user.pages.build(page_params)
    if @page.save
      flash[:success] = '投稿されました'
      redirect_to user_path(@page.user_id)
    else
      @feed_items = []
      render 'pages/new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def page_params
    params.require(:page).permit(:title, :content, :picture)
  end

  def correct_user
    @page = current_user.pages.find_by(id: params[:id])
    redirect_to root_url if @page.nil?
  end
end
