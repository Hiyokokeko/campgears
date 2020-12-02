require 'rails_helper'

RSpec.describe Page, type: :model do
  let(:user) { create(:user) }
  let(:page) { create(:page) }

  it 'user, title, contentがあれば投稿できる' do
    page = Page.new(
      user: user,
      title: 'Test title',
      content: 'Test content'
    )
    expect(page).to be_valid
  end

  it 'userが存在しなければ投稿できない' do
    page.user_id = nil
    page.valid?
    expect(page.errors).to be_added(:user_id, :blank)
  end

  it 'titleがなければ投稿できない' do
    page.title = nil
    page.valid?
    expect(page.errors).to be_added(:title, :blank)
  end

  it 'contentがなければ投稿できない' do
    page.content = nil
    page.valid?
    expect(page.errors).to be_added(:content, :blank)
  end

  it '60文字以下のtitleは投稿できる' do
    page.title = 'a' * 60
    expect(page).to be_valid
  end

  it '61文字以上のtitleは投稿できない' do
    page.title = 'a' * 61
    page.valid?
    expect(page.errors).to be_added(:title, :too_long, count: 60)
  end

  it '800文字以内のcontentは投稿できる' do
    page.content = 'a' * 800
    expect(page).to be_valid
  end

  it '801文字以上のcontentは投稿できない' do
    page.content = 'a' * 801
    page.valid?
    expect(page.errors).to be_added(:content, :too_long, count: 800)
  end

  describe '文字列に一致するpageを検索する' do
    before do
      @page1 = Page.create(
        user: user,
        title: 'first title',
        content: 'first content'
      )
      @page2 = Page.create(
        user: user,
        title: 'second title',
        content: 'this is not good'
      )
      @page3 = Page.create(
        user: user,
        title: 'third recommended books',
        content: 'this is good'
      )
    end
    context '一致するデータが見つかるとき' do
      it '検索文字列に一致するtitleをもつpageを返すこと' do
        expect(Page.search('title')).to include(@page1, @page2)
      end
      it '検索文字列に一致するcontentをもつpageを返すこと' do
        expect(Page.search('content')).to include(@page1)
      end
    end
    context '一致するデータが1件も見つからないとき' do
      it 'pageを返さないこと' do
        expect(Page.search('note')).to be_empty
      end
    end
  end
end
