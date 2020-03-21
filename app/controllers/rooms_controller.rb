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

    if current_user.blank?
      redirect_to new_room_player_path(@room.token) unless current_user.present?
    else
      attach_player_to_room unless current_user.rooms.include?(@room)
    end
  end

  def join
    @room = Room.find_by(token: params[:token])
  end

  private

  def set_username
    session[:username] = params[:user][:username] if params[:user].present?
  end

  def attach_player_to_room
    current_user.add_to(@room)
  end
end
