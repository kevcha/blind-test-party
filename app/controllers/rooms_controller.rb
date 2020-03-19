class RoomsController < ApplicationController
  def create
    @room = Room.new

    if @room.save
      redirect_to room_path(@room.token)
    else
      render :new
    end
  end

  def show
    @room = Room.find_by(token: params[:token])
  end
end
