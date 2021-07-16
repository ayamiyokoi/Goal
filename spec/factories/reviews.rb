FactoryBot.define do
  #FactoryBotを使用し、reviewデータをあらかじめ用意しておく
  factory :review do
    rate { "60" }
    review { "テスト振り返り" }
    plan { "テストプラン" }
    title { "テストトピックタイトル" }
    topic { "テストトピック" }
  end
end