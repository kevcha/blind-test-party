class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references :room, null: false, foreign_key: true
      t.string :body, null: false
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
