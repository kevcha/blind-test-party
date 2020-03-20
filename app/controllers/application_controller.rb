class ApplicationController < ActionController::Base
  def current_user
    if session[:player_id]
      Player.find(session[:player_id])
    end
  end
  helper_method :current_user
end
