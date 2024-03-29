# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :review, optional: true
  belongs_to :comment, optional: true
  belongs_to :chat, optional: true
  belongs_to :group, optional: true

  belongs_to :visitor, class_name: "User", foreign_key: "visitor_id", optional: true
  belongs_to :visited, class_name: "User", foreign_key: "visited_id", optional: true
end
