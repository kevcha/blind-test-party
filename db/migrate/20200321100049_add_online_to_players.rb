class AddOnlineToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :online, :boolean, default: false
  end
end
