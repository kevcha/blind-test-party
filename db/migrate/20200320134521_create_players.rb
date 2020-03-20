class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :username
      t.references :room, null: false, foreign_key: true
      t.boolean :ready, default: false
      t.string :punchline
      t.integer :score, default: 0

      t.timestamps
    end
  end
end
