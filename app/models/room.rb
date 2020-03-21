class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :room_players, dependent: :destroy
  has_many :players, through: :room_players
  belongs_to :dealer, optional: true, class_name: 'Player'

  before_create :set_token

  def start!
    dealer_id = players.pluck(:id).sample
    update(started: true, dealer_id: dealer_id)
  end

  def increment_score_for(id)
    players.find(id).increment_score!
  end

  def toggle_play!
    update(playing: !playing)
  end

  def stop!
    players.each(&:not_ready!)
    update(playing: false, song_id: nil)
  end

  def set_song(id)
    players.each(&:not_ready!)
    update(song_id: id)
  end

  def everyone_ready?
    players.pluck(:ready).all?(true)
  end

  def update_dealer
    sorted_ids = players.online.order(:id).pluck(:id)
    index = sorted_ids.index { |id| id == dealer.id }
    new_dealer_id = ((sorted_ids.length > index + 1) ? sorted_ids[index + 1] : sorted_ids[0])
    update(dealer_id: new_dealer_id)
  end

  private

  def set_token
    self.token = DateTime.now.strftime("%Y%m%d%H%M%S%L").to_i.to_s(36)
  end
end
