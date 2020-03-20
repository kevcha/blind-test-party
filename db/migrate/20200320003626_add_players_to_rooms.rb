class AddPlayersToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :players, :jsonb
    add_column :rooms, :dealer, :string
  end
end
