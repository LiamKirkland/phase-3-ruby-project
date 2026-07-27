class CreatePlayers < ActiveRecord::Migration[7.2]
  def change
    create_table :players do |t|
      t.string :name, null: false
      t.references :team, foreign_key: true
      t.integer :batting, null: false
      t.integer :running, null: false
      t.integer :pitching, null: false
      t.integer :fielding, null: false
      t.integer :total_skill, null: false
    end
  end
end
