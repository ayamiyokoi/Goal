# frozen_string_literal: true

json.extract! task, :id, :user_id, :name, :body, :date, :finished, :created_at, :updated_at
json.url task_url(task, format: :json)
