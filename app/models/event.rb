# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user

  validates :title, :presence => { :message => "を入力してください" }
  validates :start_time, :presence => { :message => "を入力してください" }
  validates :end_time, :presence => { :message => "を入力してください" }
end
