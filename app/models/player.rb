class Player < ApplicationRecord
  belongs_to :room

  before_create :set_punchline

  def increment_score!
    update(score: score + 1)
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
