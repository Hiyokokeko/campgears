require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end

  it 'ユーザー登録ができる' do
    expect(build(:user)).to be_valid
  end

  it 'name, email, password, password confirmationがあれば有効な状態である' do
    user = User.new(
      name: 'Aaron',
      email: 'tester@example.com',
      password: 'password',
      password_confirmation: 'password'
    )
    expect(user).to be_valid
  end

  it 'nameがなければ無効な状態であること' do
    @user.name = nil
    @user.valid?
    expect(@user.errors).to be_added(:name, :blank)
  end

  it 'nameが50文字以内であれば有効' do
    @user.name = 'a' * 50
    @user.valid?
    expect(@user).to be_valid
  end

  it 'nameが51文字以上であれば無効' do
    @user.name = 'a' * 51
    @user.valid?
    expect(@user.errors).to be_added(:name, :too_long, count: 50)
  end

  it 'passwordがなければ無効な状態であること' do
    @user.password = @user.password_confirmation = ' ' * 6
    @user.valid?
    expect(@user.errors).to be_added(:password, :blank)
  end

  it 'passwordとpassword_confirmationが一致しなければ無効' do
    @user.password = 'password'
    @user.password_confirmation = 'aaaaaaaa'
    @user.valid?
    expect(@user.errors).to be_added(:password_confirmation, :confirmation, attribute: 'パスワード')
  end

  it 'passwordが６文字以上あれば有効な状態であること ' do
    @user.password = @user.password_confirmation = 'a' * 6
    expect(@user).to be_valid
  end

  it 'passwordが6文字未満であれば無効である' do
    @user.password = 'a' * 5
    @user.valid?
    expect(@user.errors).to be_added(:password, :too_short, count: 6)
  end

  it 'emailがなければ無効な状態であること' do
    @user.email = nil
    @user.valid?
    expect(@user.errors).to be_added(:email, :blank)
  end

  it '重複したメールアドレスなら無効な状態であること' do
    user = create(:user, name: 'taro', email: 'taro@example.com')
    expect(build(:user, name: 'ziro', email: user.email)).to_not be_valid
  end

  it 'emailは小文字で保存される' do
    @user.email = 'SAMPLE@SAMPLE.COM'
    @user.save!
    expect(@user.reload.email).to eq 'sample@sample.com'
  end

  it 'emailが255文字以下であれば有効' do
    @user.email = 'a' * 244 + '@sample.com'
    expect(@user).to be_valid
  end

  it 'emailが256文字以上のユーザーを許可しない' do
    @user.email = 'a' * 245 + '@sample.com'
    @user.valid?
    expect(@user.errors).to be_added(:email, :too_long, count: 255)
  end

  describe 'メールアドレスの有効性の検証' do
    it '無効なメールアドレス' do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                             foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).to_not be_valid
      end
    end

    it '有効なメールアドレスの場合' do
      valid_addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      valid_addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end
end
