class AddPlayingToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :playing, :boolean, default: false
  end
end
