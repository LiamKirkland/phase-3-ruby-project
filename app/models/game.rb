class Game < ActiveRecord::Base
  belongs_to :home_team, class_name: "Team", inverse_of: :home_games
  belongs_to :away_team, class_name: "Team", inverse_of: :away_games

  validates :home_score, numericality: { greater_than: 0 }
  validates :away_score, numericality: { greater_than: 0 }

  def matchup_vs(team)
    if home_team_id == team.id
      puts "  \e[36mHome\e[0m v. \e[33m#{away_team.name}\e[0m"
      puts "  Final Score: \e[36m#{home_score}\e[0m to \e[33m#{away_score}\e[0m"
    else
      puts "  \e[33mAway\e[0m v. \e[36m#{home_team.name}\e[0m"
      puts "  Final Score: \e[33m#{away_score}\e[0m to \e[36m#{home_score}\e[0m"
    end
  end
end
