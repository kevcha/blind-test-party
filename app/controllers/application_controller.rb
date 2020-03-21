class ApplicationController < ActionController::Base
  def current_user
    Player.find(session[:player_id])
  rescue ActiveRecord::RecordNotFound => e
    nil
  end
  helper_method :current_user
end
