FactoryBot.define do
  # FactoryBotを使用し、comment データをあらかじめ用意しておく
  factory :comment do
    comment { "テストコメント" }
  end
end
