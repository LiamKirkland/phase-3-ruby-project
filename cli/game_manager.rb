require "date"

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
      puts "#{game.id}. \e[38;5;214m#{game.away_team.name}\e[0m at \e[36m#{game.home_team.name}\e[0m"
    end
    puts "\e[3mNote - Numbers may skip as they are based on IDs\e[0m"
    loop do
      puts "\nEnter the ID of the game you wish to view:"
      choice = gets.chomp

      game = Game.find_by(id: choice)

      if game
        puts "\n\e[38;5;214m#{game.away_team.name}\e[0m v. \e[36m#{game.home_team.name}\e[0m (ID #{game.id})"
        puts "Final Score: \e[38;5;214m#{game.away_score}\e[0m to \e[36m#{game.home_score}\e[0m"
        away_star = game.away_team.players.order(total_skill: :desc).first.name
        home_star = game.home_team.players.order(total_skill: :desc).first.name
        puts "Star Players: \e[38;5;214m#{away_star}\e[0m & \e[36m#{home_star}\e[0m"
        puts "Played on #{game.date_played.strftime('%m/%d/%Y')}"
        break
      else
        puts FAILURE_MESSAGE
      end
    end
  end

  def create_game
    puts "\n-= Create New Game =-"
    loop do
      game_hash = prompt_game_attributes
      new_game = Game.new(game_hash)

      puts "=" * 50
      display_game(new_game)

      confirm = nil
      loop do
        print "\nDoes this look correct? (Y/N): "
        confirm = gets.chomp.upcase
        break if ['Y', 'N', 'YES', 'NO'].include?(confirm)

        puts FAILURE_MESSAGE
      end

      if ['Y', 'YES'].include?(confirm)
        puts "\n\e[3;32mSaved game to database....\e[0m"
        new_game.save
        break
      else
        puts "\e[3mRestarting form input....\e[0m\n"
      end
    end
  end

  def update_game
    puts "\n-= Update Game =-"
    Game.all.each do |game|
      puts "#{game.id}. \e[38;5;214m#{game.away_team.name}\e[0m at \e[36m#{game.home_team.name}\e[0m"
    end
    puts "\e[3mNote - Numbers may skip as they are based on IDs\e[0m"

    loop do
      puts "\nEnter the ID of the game you wish to update:"
      choice = gets.chomp

      game = Game.find_by(id: choice)

      if game
        display_game(game)
        puts "=" * 50
        loop do
          game_hash = prompt_game_attributes(game)
          game.assign_attributes(game_hash)

          puts "=" * 50
          display_game(game)

          confirm = nil
          loop do
            print "\nSave these changes? (Y/N): "
            confirm = gets.chomp.upcase
            break if ['Y', 'N', 'YES', 'NO'].include?(confirm)

            puts FAILURE_MESSAGE
          end

          if ['Y', 'YES'].include?(confirm)
            puts "\n\e[3;32mSaved changes....\e[0m"
            game.save
            break
          else
            puts "\e[3mRestarting form input....\e[0m\n"
          end
        end
        break
      else
        puts FAILURE_MESSAGE
      end
    end
  end

  def delete_game
    puts "\n-= Delete Game =-"
    Game.all.each do |game|
      puts "#{game.id}. \e[38;5;214m#{game.away_team.name}\e[0m at \e[36m#{game.home_team.name}\e[0m"
    end
    puts "\e[3mNote - Numbers may skip as they are based on IDs\e[0m"

    loop do
      puts "\nEnter the ID of the game you wish to delete:"
      choice = gets.chomp

      game = Game.find_by(id: choice)

      if game
        display_game(game)

        confirm = nil
        loop do
          print "\n⚠️ \e[1;33mAre you sure you want to delete this game? This action cannot be undone: \e[0m"
          confirm = gets.chomp.upcase
          break if ['Y', 'N', 'YES', 'NO'].include?(confirm)

          puts FAILURE_MESSAGE
        end

        if ['Y', 'YES'].include?(confirm)
          puts "\n\e[3;31mGame has been deleted.\e[0m"
          game.destroy
          break
        end

        break
      else
        puts FAILURE_MESSAGE
      end
    end
  end

  private

  def display_game(game)
    puts "ID: #{game.id}" if game.id
    puts "\e[38;5;214mAway Team\e[0m: #{game.away_team.name}"
    puts "\e[36mHome Team\e[0m: #{game.home_team.name}"
    puts "Final Score: \e[38;5;214m#{game.away_score}\e[0m - \e[36m#{game.home_score}\e[0m "
    puts "Date Played: #{game.date_played.strftime('%m/%d/%Y')}"
  end

  def grab_datetime(existing_date = nil)
    loop do
      print "Enter a date (MM/DD/YYYY)#{" [#{existing_date.strftime('%m/%d/%Y')}]" if existing_date}: "
      input = gets.chomp

      return existing_date if input.empty? && existing_date

      begin
        return DateTime.strptime(input, "%m/%d/%Y")
      rescue ArgumentError
        puts FAILURE_MESSAGE
      end
    end
  end

  def prompt_game_attributes(existing_game = nil)
    game_hash = {
      away_team_id: existing_game&.away_team_id,
      home_team_id: existing_game&.home_team_id,
      away_score: existing_game&.away_score,
      home_score: existing_game&.home_score,
      date_played: existing_game&.date_played,
    }

    puts "Pick the \e[38;5;214mAway\e[0m and \e[36mHome\e[0m teams"
    Team.all.each do |team|
      puts "#{team.id}. #{team.name}"
    end

    puts "\nEnter the team's ID to select them"
    puts "(press Enter to keep the current value)" if existing_game

    loop do
      print "\e[38;5;214mAway Team ID#{" [#{game_hash[:away_team_id]}]" if existing_game}: \e[0m"
      input = gets.chomp
      break if input.empty? && existing_game

      choice = input.to_i
      if Team.find_by(id: choice)
        game_hash[:away_team_id] = choice
        break
      else
        puts FAILURE_MESSAGE
      end
    end

    loop do
      print "\e[36mHome Team ID#{" [#{game_hash[:home_team_id]}]" if existing_game}: \e[0m"
      input = gets.chomp
      break if input.empty? && existing_game

      choice = input.to_i
      if game_hash[:away_team_id] == choice
        puts "⚠️ \e[33mHome and Away teams cannot be the same!\e[0m"
      elsif Team.find_by(id: choice)
        game_hash[:home_team_id] = choice
        break
      else
        puts FAILURE_MESSAGE
      end
    end

    puts "\nEnter the game's final score"
    loop do
      print "\e[38;5;214m#{Team.find(game_hash[:away_team_id]).name} score#{" [#{game_hash[:away_score]}]" if existing_game}: \e[0m"
      input = gets.chomp.strip
      break if input.empty? && existing_game

      if input.to_i >= 0 && input.match?(/\A\d+\z/)
        game_hash[:away_score] = input.to_i
        break
      else
        puts FAILURE_MESSAGE
      end
    end

    loop do
      print "\e[36m#{Team.find(game_hash[:home_team_id]).name} score#{" [#{game_hash[:home_score]}]" if existing_game}: \e[0m"
      input = gets.chomp.strip
      break if input.empty? && existing_game

      if input.to_i >= 0 && input.match?(/\A\d+\z/)
        game_hash[:home_score] = input.to_i
        break
      else
        puts FAILURE_MESSAGE
      end
    end

    game_hash[:date_played] = grab_datetime(existing_game&.date_played)

    game_hash
  end
end
