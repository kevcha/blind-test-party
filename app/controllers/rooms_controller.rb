class RoomsController < ApplicationController
  before_action :set_username, only: :show

  def create
    @room = Room.new

    if @room.save
      redirect_to new_room_player_path(@room.token)
    else
      redirect_to root_path
    end
  end

  def show
    @room = Room.find_by(token: params[:token])
    redirect_to new_room_player_path(@room.token), notice: "La room est pleine, t'arrives trop tard 🤬" unless current_user
  end

  def join
    @room = Room.find_by(token: params[:token])
  end

  private

  def set_username
    session[:username] = params[:user][:username] if params[:user].present?
  end
end
