class PagesController < ApplicationController
  before_action :logged_in_user, only: %i[new edit create update destroy]
  before_action :correct_user,   only: %i[edit update destroy]
  before_action :set_category, only: %i[index new create edit update]

  # 投稿一覧/root
  # カテゴリー分け
  def index
    # urlにcategory_id(params)がある場合
    if params[:category_id]
      # Categoryのデータベースのテーブルから一致するidを取得
      @category = Category.find(params[:category_id])
      # category_idと紐づく投稿を取得
      @pages = @category.pages.paginate(page: params[:page])
    # 全ての投稿
    else
      @pages = Page.paginate(page: params[:page], per_page: 10).search(params[:search])
    end
  end

  def show
    @page = Page.find_by(id: params[:id])
    return unless @page.nil?

    flash[:success] = 'そのページは削除されています'
    redirect_to root_url
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
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update(page_params)
      flash[:success] = '編集しました'
      redirect_to @page
    else
      render 'edit'
    end
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

  # カテゴリーチェックボックス
  def set_category
    @categories = Category.all
  end
end
