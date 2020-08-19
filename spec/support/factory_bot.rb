# FactoryBot を省略してデータ生成できる
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
