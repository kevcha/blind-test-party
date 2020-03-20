class MakeDealerReferenceFromRooms < ActiveRecord::Migration[6.0]
  def change
    remove_column :rooms, :dealer
    add_reference :rooms, :dealer
  end
end
