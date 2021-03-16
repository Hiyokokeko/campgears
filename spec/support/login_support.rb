module LoginSupport
  def sign_in_as(user)
    visit root_path
    click_link 'ログイン'
    fill_in 'session[email]', with: user.email
    fill_in 'session[password]', with: user.password
    click_button 'ログイン'
    expect(page).to have_content '投稿した記事一覧'
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end
