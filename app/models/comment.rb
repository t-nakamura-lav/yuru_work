class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  has_many :notifications, dependent: :destroy

  validates :comment, presence: true, length: { maximum: 200, minimum: 2 }
end
