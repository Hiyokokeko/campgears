class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy like_pages]
  before_action :logged_in_user, only: %i[index edit update destroy like_pages]
  before_action :correct_user,   only: %i[edit update]
  before_action :admin_user,     only: %i[index destroy]
  before_action :check_guest, only: %i[update destroy]
  # GET /users
  # GET /users.json

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @pages = @user.pages.paginate(page: params[:page])
  end

  # ユーザーがいいねした記事一覧
  def like_pages
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
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

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: '更新しました' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def guest_login
    user = User.find_by(email: 'test@example.com')
    log_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
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

  # 管理者かどうか確認
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  # ゲストユーザーの変更・削除はできない
  def check_guest
    return unless @user.email == 'test@example.com'

    redirect_to root_path, alert: 'ゲストユーザーの変更・削除はできません。'
  end

end
