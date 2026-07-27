class CreateGames < ActiveRecord::Migration[7.2]
  def change
    create_table :games do |t|
      t.references :home_team, null: false, foreign_key: { to_table: :teams }
      t.references :away_team, null: false, foreign_key: { to_table: :teams }
      t.integer :home_score, null: false
      t.integer :away_score, null: false
      t.datetime :date_played, null: false
      t.timestamps
    end
  end
end
