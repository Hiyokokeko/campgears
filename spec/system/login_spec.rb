require 'rails_helper'

RSpec.describe 'Login', type: :system do
  before do
    @user = create(:user)
  end

  it 'ログインページが正しく表示される' do
    visit '/login'

    expect(page).to have_selector 'h1', text: 'ログイン'
    expect(page).to have_text 'メールアドレス'
    expect(page).to have_text 'パスワード'
    expect(page).to have_link 'パスワードを忘れた場合'
    expect(page).to_not have_checked_field('ログイン状態を保存する')
    expect(page).to have_button 'ログイン'
    expect(page).to have_link '新規ユーザー登録はこちら'
  end

  describe 'sessions#new' do
    it 'メールアドレス,パスワードがどちらも正しい場合、ログインできる' do
      visit '/login'
      # メールアドレスとパスワードが未入力
      click_button 'ログイン'
      expect(page).to have_content 'メールアドレスとパスワードの組み合わせが正しくありません'
      # 誤ったメールアドレス
      fill_in 'session[email]', with: 'invalidemail@invalid.com'
      fill_in 'session[password]', with: @user.password
      click_button 'ログイン'
      expect(page).to have_content 'メールアドレスとパスワードの組み合わせが正しくありません'
      # 誤ったpassword
      fill_in 'session[email]', with: @user.email
      fill_in 'session[password]', with: 'nopassword'
      click_button 'ログイン'
      expect(page).to have_content 'メールアドレスとパスワードの組み合わせが正しくありません'
      # 有効なメールアドレス、パスワード
      fill_in 'session[email]', with: @user.email
      fill_in 'session[password]', with: @user.password
      click_button 'ログイン'
      expect(page).to have_content '投稿した記事一覧'
    end
  end

  it 'ゲストログインボタンを押すとゲストユーザーとしてログイン可能' do
    create(:guest_user)
    visit root_path

    click_link 'ゲストログイン'
    expect(page).to have_content 'ゲストユーザーとしてログインしました'
    expect(page).to have_content 'ゲストユーザーさん'
    expect(page).not_to have_content 'ゲストログイン'
  end

  describe 'sessions#destroy' do
    it 'ログアウトすることができる' do
      visit '/login'

      fill_in 'session[email]', with: @user.email
      fill_in 'session[password]', with: @user.password
      click_button 'ログイン'
      expect(page).to have_content '投稿した記事一覧'

      # ヘッダーのドロップダウンを開く
      find('.dropdown').click
      click_link 'ログアウト'

      # ログアウトされ、ホーム画面にリダイレクト
      expect(current_path).to eq root_path
      expect(page).to have_content 'ログイン'
    end
  end
end
