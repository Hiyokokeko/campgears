require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:page) { create(:page) }
  let(:comment) { create(:comment) }

  it 'user, page, contentがあれば投稿できる' do
    comment = Comment.new(
      user: user,
      page: page,
      content: 'my string'
    )
    expect(comment).to be_valid
  end

  it 'contentがなければ投稿できない' do
    comment.content = ''
    comment.valid?
    expect(comment.errors).to be_added(:content, :blank)
  end

  it '140文字以下のコメントは投稿できる' do
    comment.content = 'a' * 140
    expect(comment).to be_valid
  end

  it '141文字以上のコメントは投稿できない' do
    comment.content = 'a' * 141
    comment.valid?
    expect(comment.errors).to be_added(:content, :too_long, count: 140)
  end
end
