class Team < ActiveRecord::Base
  has_many :home_games, class_name: "Game", foreign_key: "home_team_id", inverse_of: :home_team
  has_many :away_games, class_name: "Game", foreign_key: "away_team_id", inverse_of: :away_team
  has_many :players

  def games
    Game.where("home_team_id = :id OR away_team_id = :id", id: id)
  end

  def games_played
    games.count
  end

  def games_won
    home_games.where("home_score > away_score").count +
      away_games.where("away_score > home_score").count
  end

  def games_lost
    home_games.where("home_score < away_score").count +
      away_games.where("away_score < home_score").count
  end

  def games_tied
    home_games.where("home_score = away_score").count +
      away_games.where("away_score = home_score").count
  end
end
