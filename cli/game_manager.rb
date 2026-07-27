class GameManager
  def view_all_games
    puts "\n-=All Games =-"
    games = Game.all

    if games.empty?
      puts "No games founds."
    else
      games.each do |game|
        display_game(game)
        puts "=" * 50
      end
    end
  end

  def view_game
    puts "\n-= View Game Details =-"
    Game.all.each do |game|
      puts "#{game.id}. \e[33m#{game.away_team.name}\e[0m at \e[36m#{game.home_team.name}\e[0m"
    end
    puts "\e[3mNote - Numbers may skip as they are based on IDs\e[0m"
    loop do
      puts "\nEnter the ID of the game you wish to view:"
      choice = gets.chomp

      game = Game.find_by(id: choice)

      if game
        puts "\n\e[33m#{game.away_team.name}\e[0m v. \e[36m#{game.home_team.name}\e[0m (ID #{game.id})"
        puts "Final Score: \e[33m#{game.away_score}\e[0m to \e[36m#{game.home_score}\e[0m"
        away_star = game.away_team.players.order(total_skill: :desc).first.name
        home_star = game.home_team.players.order(total_skill: :desc).first.name
        puts "Star Players: \e[33m#{away_star}\e[0m & \e[36m#{home_star}\e[0m"
        puts "Played on #{game.date_played.strftime('%m/%d/%Y')}"
        break
      else
        puts FAILURE_MESSAGE
      end
    end
  end

  private

  def display_game(game)
    puts "ID: #{game.id}"
    puts "\e[33mAway Team\e[0m: #{game.away_team.name}"
    puts "\e[36mHome Team\e[0m: #{game.home_team.name}"
    puts "Final Score: \e[33m#{game.away_score}\e[0m - \e[36m#{game.home_score}\e[0m "
    puts "Date Played: #{game.date_played.strftime('%m/%d/%Y')}"
  end

end
