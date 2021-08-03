# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :user

  validates :title, :presence => { :message => "を入力してください" }
  validates :start_time, :presence => { :message => "を入力してください" }
  validates :end_time, :presence => { :message => "を入力してください" }
  validate :start_end_check

  def start_end_check
    unless self.end_time == nil
      errors.add(:end_time, "は開始日時より前の日付は登録できません。") unless
      self.start_time < self.end_time
    end
  end
end
