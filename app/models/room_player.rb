class RoomPlayer < ApplicationRecord
  belongs_to :room
  belongs_to :player
end
