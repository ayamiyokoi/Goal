# frozen_string_literal: true

json.extract! review, :id, :user_id, :tag_id, :rate, :review, :today_id, :plan, :tomorrow_id, :title, :topic, :created_at, :updated_at
json.url review_url(review, format: :json)
