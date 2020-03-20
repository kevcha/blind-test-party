module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_player

    def connect
      player = Player.find(request.session[:player_id])
      self.current_player = player
      reject_unauthorized_connection unless player
    end
  end
end
