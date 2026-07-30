class AddSnapshotsToGames < ActiveRecord::Migration[7.2]
  def change
    add_column :games, :home_team_name, :string, null: false
    add_column :games, :home_star, :string, null: false
    add_column :games, :away_team_name, :string, null: false
    add_column :games, :away_star, :string, null: false
  end
end
