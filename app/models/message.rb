class Message < ApplicationRecord
  belongs_to :room
  belongs_to :player

  validates :body, presence: true
end
