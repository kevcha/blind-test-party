class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_#{params[:token]}"
    broadcast_game_status
  end

  def unsubscribed
    current_player.destroy
    broadcast_game_status
  end

  def broadcast_game_status
    room.reload
    ActionCable.server.broadcast("room_#{params[:token]}", {
      type: 'join',
      players: players,
      dealer: room.dealer,
      started: room.started?,
      song_id: room.song_id,
      everyone_ready: room.everyone_ready?,
      playing: room.playing?,
      messages: messages
    })
  end

  def refresh
    broadcast_game_status
  end

  def message(data)
    Message.create(body: data['body'], player: current_player, room: room)
    broadcast_game_status
  end

  def found(data)
    room.increment_score_for(data['userId'])
    room.update_dealer
    room.stop!
    broadcast_game_status
  end

  def setSong(data)
    room.set_song(data['id'])
    broadcast_game_status
  end

  def start
    room.start! unless room.started?
    broadcast_game_status
  end

  def next
    room.update_dealer
    room.stop!
    broadcast_game_status
  end

  def toggle
    room.toggle_play!
    broadcast_game_status
  end

  def ready
    current_player.ready!
    broadcast_game_status
  end

  def players
    room.players.reload.map do |player|
      {
        id: player.id,
        username: player.username,
        punchline: player.punchline,
        score: player.score,
        ready: player.ready
      }
    end
  end

  def room
    Room.find_by(token: params[:token])
  end

  def messages
    room.messages.reload.order(created_at: :desc).map do |message|
      {
        body: message.body,
        player: message.player.username
      }
    end
  end
end
