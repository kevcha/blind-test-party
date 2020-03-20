class ApplicationController < ActionController::Base
  def current_user
    session[:username]
  end
  helper_method :current_user
end
