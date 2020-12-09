require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  describe 'ログインユーザーのみコメントの投稿ができる' do
    context 'ログインした時' do
      before do
        @user = create(:user)
        @page = create(:page)
        sign_in_as @user
      end

      it '詳細ページにコメント欄が表示される' do
        visit page_path(@page)

        expect(page).to have_field 'comment[content]'
        expect(page).to have_button '送信'
        expect(page).to have_selector 'h4', text: 'コメント'
      end

      it 'コメントの投稿・削除ができる' do
        visit page_path(@page)

        # コメントを投稿
        fill_in 'comment[content]', with: 'わかりやすい'
        click_button '送信'

        # 詳細ページにリダイレクト
        expect(current_path).to eq page_comments_path(@page)

        # コメントが保存されているか
        @comment = Comment.first
        expect(@comment.content).to eq('わかりやすい')

        # 詳細ページにコメントと削除リンクが表示されている
        expect(page).to have_text 'わかりやすい'
        expect(page).to have_link '削除'

        # コメントを削除する
        expect do
          click_link '削除'
        end.to change(Comment, :count).by(-1)

        # 削除リンクが表示されない
        expect(page).not_to have_link '削除'
      end
    end

    context 'ログインしていない時' do
      before do
        @user = create(:user)
        @page = create(:page)
      end

      it '詳細ページにコメント欄が表示されない' do
        visit page_path(@page)

        expect(page).not_to have_field 'comment[content]'
        expect(page).not_to have_button '送信'
        expect(page).to have_selector 'h4', text: 'コメント'
      end
    end
  end
end
