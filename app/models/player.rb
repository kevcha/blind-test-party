class Player < ApplicationRecord
  has_many :room_players
  has_many :rooms, through: :room_players

  before_create :set_punchline

  scope :online, -> { where(online: true) }

  def increment_score!
    update(score: score + 1)
  end

  def online!
    reload
    update(online: true)
  end

  def add_to(room)
    room_players.create(room: room)
  end

  def offline!
    reload
    update(online: false)
  end

  def ready!
    reload
    update(ready: true)
  end

  def not_ready!
    update(ready: false)
  end

  private

  def set_punchline
    self.punchline = [
      '“Je suis chaud bouillant“',
      '“Je suis pas pour faire tourner les serviettes“',
      '“Bande de rigolos“',
      '“Saint Etienne 💚 > Lyon 👎“',
      '“Qu‘est ce que je fous là ⁇“',
      '“quiéyeière ér ér ér???“',
    ].sample
  end
end
