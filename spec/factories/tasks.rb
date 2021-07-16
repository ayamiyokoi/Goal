FactoryBot.define do
  #FactoryBotを使用し、taskデータをあらかじめ用意しておく
  factory :task do
    name { "メールチェック" }
    body { "テスト" }
    date { "Tue, 20 Oct 2015 16:00:00 +0900" }
  end
end