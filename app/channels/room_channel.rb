class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_#{params[:token]}"
    broadcast_game_status
  end

  def unsubscribed
    broadcast_game_status
  end

  def broadcast_game_status
    ActionCable.server.broadcast("room_#{params[:token]}", {
      type: 'join',
      players: players,
      dealer: room&.dealer
    })
  end

  def refresh
    broadcast_game_status
  end

  def found(data)
    room.increment_score_for(data['username'])
    room.update_dealer
    broadcast_game_status
  end

  def start
    room.start_with(players) if room.players.blank?
    broadcast_game_status
  end

  def players
    players_from_rooms || players_from_connections
  end

  def players_from_connections
    connection.server.connections.map do |conn|
      {
        username: conn.current_user[:username],
        punchline: conn.current_user[:punchline],
        score: 0
      }
    end
  end

  def players_from_rooms
    if room.players.present?
      room.players
    end
  end

  def room
    Room.find_by(token: params[:token])
  end
end
