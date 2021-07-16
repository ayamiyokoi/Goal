FactoryBot.define do
  #FactoryBotを使用し、userデータをあらかじめ用意しておく
  factory :user do
    name { "テスト" }
    email { "test@example.com" }
    password { "testtaro" }
  end
end