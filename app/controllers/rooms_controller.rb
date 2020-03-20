class RoomsController < ApplicationController
  before_action :set_username, only: :show

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

    redirect_to join_room_path(@room.token) unless session[:username].present?
  end

  def join
    @room = Room.find_by(token: params[:token])
  end

  private

  def set_username
    session[:username] = params[:user][:username] if params[:user].present?
  end
end
