require 'rails_helper'

RSpec.describe 'Pages', type: :system do
  describe 'ユーザはページの作成、編集、削除ができる' do
    context 'ログインしたとき' do
      before do
        @user = create(:user)
        sign_in_as @user
      end

      it '新規投稿ページが表示される' do
        visit new_page_path

        expect(page).to have_selector 'h3', text: '新規投稿'
        expect(page).to have_text '画像'
        expect(page).to have_text 'キャンプギアのタイトル'
        expect(page).to have_text 'キャンプギアの内容やおすすめの理由'
        expect(page).to have_text 'カテゴリー'
        expect(page).to have_button '投稿する'
      end

      it '新規投稿、投稿削除ができる' do
        visit new_page_path

        fill_in 'page[title]', with: 'camp gears'
        fill_in 'page[content]', with: 'camp gears content'
        click_button '投稿する'

        # ユーザーページにリダイレクトされるか
        expect(current_path).to eq user_path(@user)

        # 投稿が保存されているか
        @page = Page.first
        expect(@page.title).to eq('camp gears')
        expect(@page.content).to eq('camp gears content')

        # 投稿詳細ページに遷移
        visit "/pages/#{@page.id}"
        expect(page).to have_text 'camp gears'
        expect(page).to have_text 'camp gears content'

        # 投稿の編集
        click_link '編集'
        expect(page).to have_text '編集ページ'
        fill_in 'page[title]', with: 'edit gears'
        fill_in 'page[content]', with: 'edit gears content'
        click_button '投稿する'

        # 詳細ページにリダイレクトされるか
        expect(current_path).to eq page_path(@page)
        expect(page).to have_content '編集しました'

        # 投稿の削除
        link = find_link '削除'
        expect(link['data-confirm']).to eq '削除しますか？'

        # 投稿が削除されているか
        expect(Page.where(id: @user.id).count).to eq 0
      end
    end
  end
end
