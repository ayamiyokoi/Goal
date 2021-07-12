# frozen_string_literal: true

Chartkick.options = {
  xtitle: "日付",
  ytitle: "達成率",
  width: "800px",
  height: "500px",
  min: 0,
  max: 100,
  xmin: @from,
  xmax: @to,
  empty: "データがありません"
}