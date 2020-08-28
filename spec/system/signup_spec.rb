require 'rails_helper'

RSpec.describe 'Signup', type: :system do
  it '新規登録ページが正しく表示される' do
    visit '/users/new'

    expect(page).to have_selector 'h1', text: '新規ユーザー登録'
    expect(page).to have_field '名前'
    expect(page).to have_field 'メールアドレス'
    expect(page).to have_field 'パスワード'
    expect(page).to have_field 'パスワード再入力'
    expect(page).to have_button 'アカウントを新規作成'
  end

  describe 'ログインしようとした時' do
    it '有効な値が入力されていたら登録を許可する' do
      visit '/users/new'

      fill_in 'user[name]', with: 'testuser'
      fill_in 'user[email]', with: 'sample@sample.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button 'アカウントを新規作成'

      # ホーム画面にリダイレクト
      expect(current_path).to eq root_path
      expect(page).to have_content 'アカウント登録が完了しました'
    end

    it '各項目に有効な値が入力されていなければ登録を許可しない' do
      visit '/users/new'

      fill_in 'user[name]', with: ''
      fill_in 'user[email]', with: 'sample@sample'
      fill_in 'user[password]', with: 'word'
      fill_in 'user[password_confirmation]', with: 'nopassword'
      click_button 'アカウントを新規作成'
      expect(page).to have_content '名前を入力してください'
      expect(page).to have_content 'メールアドレスは不正な値です'
      expect(page).to have_content 'パスワード再入力とパスワードの入力が一致しません'
      expect(page).to have_content 'パスワードは6文字以上で入力してください'
    end
  end
end
