class RemoveTotalSkillFromPlayers < ActiveRecord::Migration[7.2]
  def change
    remove_column :players, :total_skill, :integer
  end
end
