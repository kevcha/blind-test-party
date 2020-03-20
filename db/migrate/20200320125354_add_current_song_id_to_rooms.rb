class AddCurrentSongIdToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :song_id, :string
  end
end
