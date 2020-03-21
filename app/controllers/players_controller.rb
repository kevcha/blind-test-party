class PlayersController < ApplicationController
  before_action :set_room

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      save_id_in_session
      redirect_to room_path(@room.token)
    else
      render :new
    end
  end

  private

  def set_room
    @room = Room.find_by(token: params[:room_token])
  end

  def player_params
    params
      .require(:player)
      .permit(:username)
      .merge(rooms: [@room])
  end

  def save_id_in_session
    session[:player_id] = @player.id
  end
end
