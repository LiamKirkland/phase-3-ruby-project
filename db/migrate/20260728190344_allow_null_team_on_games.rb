class AllowNullTeamOnGames < ActiveRecord::Migration[7.2]
  def change
    change_column_null :games, :home_team_id, true
    change_column_null :games, :away_team_id, true

    remove_foreign_key :games, :teams, column: :home_team_id
    remove_foreign_key :games, :teams, column: :away_team_id
    add_foreign_key :games, :teams, column: :home_team_id, on_delete: :nullify
    add_foreign_key :games, :teams, column: :away_team_id, on_delete: :nullify
  end
end
