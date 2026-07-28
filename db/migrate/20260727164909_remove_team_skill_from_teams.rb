class RemoveTeamSkillFromTeams < ActiveRecord::Migration[7.2]
  def change
    remove_column :teams, :team_skill, :integer
  end
end
