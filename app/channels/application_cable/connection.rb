module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = {
        username: request.session.fetch("username", nil),
        punchline: punchlines.sample
      }
      reject_unauthorized_connection unless current_user
    end

    def punchlines
      [
        '“Je suis chaud bouillant“',
        '“Je suis pas pour faire tourner les serviettes“',
        '“Bande de rigolos“',
        '“Saint Etienne sera toujours devant Lyon 💚“',
        '“Qu‘est ce que je fous là ⁇“',
        '“quiéyeière ér ér ér???“',
      ]
    end
  end
end
