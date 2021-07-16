FactoryBot.define do
  #FactoryBotを使用し、goalデータをあらかじめ用意しておく
  factory :goal do
    name { "契約1件" }
    date {"Tue, 20 Oct 2015 16:00:00 +0900"}
  end
end