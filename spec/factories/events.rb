FactoryBot.define do
  # FactoryBotを使用し、eventデータをあらかじめ用意しておく
  factory :event do
    title { "メールチェック" }
    start_time { "Tue, 20 Oct 2015 16:00:00 +0900" }
    end_time { "Tue, 20 Oct 2015 17:00:00 +0900ト" }
  end
end
