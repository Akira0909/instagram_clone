class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  has_many :notifications, dependent: :destroy
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :micropost_id, presence: true
  validates :content, presence: true
end