class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy like_pages]
  before_action :logged_in_user, only: %i[index edit update destroy like_pages]
  before_action :correct_user,   only: %i[edit update]
  # GET /users
  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)
    respond_to do |format|
    if @user.save
      log_in @user
      format.html { redirect_to root_url, notice: 'アカウント登録が完了しました' }
      format.json { render :show, status: :created, location: @user }
    else
      format.html { render :new }
      format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # beforeアクション
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
