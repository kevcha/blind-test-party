class RoomsController < ApplicationController
  before_action :set_username, only: :show

  def create
    @room = Room.new

    if @room.save
      redirect_to room_path(@room.token)
    else
      redirect_to root_path
    end
  end

  def show
    @room = Room.find_by(token: params[:token])

    redirect_to root_path, notice: "La room est pleine, t'arrives trop tard 🤬" if @room.players.present?

    render :join if session[:username].blank?
  end

  def join
    @room = Room.find_by(token: params[:token])
  end

  private

  def set_username
    session[:username] = params[:user][:username] if params[:user].present?
  end
end
