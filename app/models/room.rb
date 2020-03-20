class Room < ApplicationRecord
  before_create :set_token

  def start_with(players)
    dealer = players.sample[:username]
    update(players: players, dealer: dealer)
  end

  def increment_score_for(username)
    u_players = players
    u_players.each do |player|
      player['score'] += 5 if player['username'] == username
    end
    update(players: u_players)
  end

  def update_dealer
    sorted_players = players.sort_by { |player| player['username'] }
    index = sorted_players.index { |player| player['username'] == dealer }
    new_dealer = ((players.length > index + 1) ? sorted_players[index + 1] : sorted_players[0])['username']
    update(dealer: new_dealer)
  end

  private

  def set_token
    self.token = DateTime.now.strftime("%Y%m%d%k%M%S%L").to_i.to_s(36)
  end
end
