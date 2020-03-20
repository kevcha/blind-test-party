class AddStartedToRooms < ActiveRecord::Migration[6.0]
  def change
    add_column :rooms, :started, :boolean, default: false
    remove_column :rooms, :players
    remove_column :rooms, :dealer
    add_column :rooms, :dealer, :integer
  end
end
