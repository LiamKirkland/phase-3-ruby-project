require "date"

class GameManager
  def view_all_games
    display_banner
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
    display_banner
    puts "\n-= View Game Details =-"
    games = Game.all.to_a

    games.each_with_index do |game, index|
      away_name = game.away_team&.name || "\e[3mTeam Deleted\e[0m"
      home_name = game.home_team&.name || "\e[3mTeam Deleted\e[0m"
      puts "#{index + 1}. \e[38;5;214m#{away_name}\e[0m at \e[36m#{home_name}\e[0m"
    end

    loop do
      print "\nEnter the number of the game you wish to view: "
      choice = gets.chomp

      game = if choice.match?(/\A\d+\z/) && choice.to_i.between?(1, games.size)
               games[choice.to_i - 1]
             end

      if game
        puts "\n\e[38;5;214m#{game.away_team&.name || "\e[3mTeam Deleted\e[0m"}\e[0m v. \e[36m#{game.home_team&.name || "\e[3mTeam Deleted\e[0m"}\e[0m (ID #{game.id})"
        puts "Final Score: \e[38;5;214m#{game.away_score}\e[0m to \e[36m#{game.home_score}\e[0m"
        away_star = if game.away_team.nil?
                      "\e[3mTeam Deleted\e[0m"
                    elsif game.away_team.players.empty?
                      "\e[3mNo Players\e[0m"
                    else
                      game.away_team.players.max_by(&:total_skill).name
                    end
        home_star = if game.home_team.nil?
                      "\e[3mTeam Deleted\e[0m"
                    elsif game.home_team.players.empty?
                      "\e[3mNo Players\e[0m"
                    else
                      game.home_team.players.max_by(&:total_skill).name
                    end
        puts "Star Players: \e[38;5;214m#{away_star}\e[0m & \e[36m#{home_star}\e[0m"
        puts "Played on #{game.date_played.strftime('%m/%d/%Y')}"
        break
      else
        puts FAILURE_MESSAGE
      end
    end
  end

  def create_game
    display_banner
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
    display_banner
    puts "\n-= Update Game =-"
    games = Game.all.to_a

    games.each_with_index do |game, index|
      away_name = game.away_team&.name || "\e[3mTeam Deleted\e[0m"
      home_name = game.home_team&.name || "\e[3mTeam Deleted\e[0m"
      puts "#{index + 1}. \e[38;5;214m#{away_name}\e[0m at \e[36m#{home_name}\e[0m"
    end

    loop do
      print "\nEnter the number of the game you wish to update: "
      choice = gets.chomp

      game = if choice.match?(/\A\d+\z/) && choice.to_i.between?(1, games.size)
               games[choice.to_i - 1]
             end

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
    display_banner
    puts "\n-= Delete Game =-"
    games = Game.all.to_a

    games.each_with_index do |game, index|
      away_name = game.away_team&.name || "\e[3mTeam Deleted\e[0m"
      home_name = game.home_team&.name || "\e[3mTeam Deleted\e[0m"
      puts "#{index + 1}. \e[38;5;214m#{away_name}\e[0m at \e[36m#{home_name}\e[0m"
    end

    loop do
      print "\nEnter the number of the game you wish to delete: "
      choice = gets.chomp

      game = if choice.match?(/\A\d+\z/) && choice.to_i.between?(1, games.size)
               games[choice.to_i - 1]
             end

      if game
        puts "=" * 50
        display_game(game)
        confirm = nil
        loop do
          print "\n⚠️ \e[1;33mAre you sure you want to delete this game? This action cannot be undone: \e[0m"
          confirm = gets.chomp.upcase
          break if ['Y', 'N', 'YES', 'NO'].include?(confirm)

          puts FAILURE_MESSAGE
        end

        if ['Y', 'YES'].include?(confirm)
          game.destroy
          puts "\n\e[3;31mGame has been deleted.\e[0m"
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
    puts "\e[38;5;214mAway Team\e[0m: #{game.away_team&.name || "\e[3mTeam Deleted\e[0m"}"
    puts "\e[36mHome Team\e[0m: #{game.home_team&.name || "\e[3mTeam Deleted\e[0m"}"
    puts "Final Score: \e[38;5;214m#{game.away_score}\e[0m - \e[36m#{game.home_score}\e[0m "
    puts "Date Played: #{game.date_played.strftime('%m/%d/%Y')}"
  end

  def grab_datetime(existing_date = nil)
    loop do
      print "Enter a date (MM/DD/YYYY)#{" [#{existing_date.strftime('%m/%d/%Y')}]" if existing_date}: "
      input = gets.chomp

      return existing_date if input.empty? && existing_date

      begin
        parsed_date = DateTime.strptime(input, "%m/%d/%Y")

        return parsed_date unless parsed_date > DateTime.now

        puts "⚠️ \e[33mDate cannot be in the future.\e[0m"
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
    teams = Team.all.to_a
    teams.each_with_index do |team, index|
      puts "#{index + 1}. #{team.name}"
    end

    puts "\nEnter the team's number to select them"
    puts "(press Enter to keep the current value)" if existing_game

    away_team_label = game_hash[:away_team_id] ? Team.find(game_hash[:away_team_id]).name : nil
    loop do
      print "\e[38;5;214mAway Team#{" [#{away_team_label}]" if existing_game}: \e[0m"
      input = gets.chomp
      break if input.empty? && existing_game

      if input.match?(/\A\d+\z/) && input.to_i.between?(1, teams.size)
        game_hash[:away_team_id] = teams[input.to_i - 1].id
        break
      else
        puts FAILURE_MESSAGE
      end
    end

    home_team_label = game_hash[:home_team_id] ? Team.find(game_hash[:home_team_id]).name : nil
    loop do
      print "\e[36mHome Team#{" [#{home_team_label}]" if existing_game}: \e[0m"
      input = gets.chomp
      break if input.empty? && existing_game

      if input.match?(/\A\d+\z/) && input.to_i.between?(1, teams.size)
        selected_team = teams[input.to_i - 1]
        if game_hash[:away_team_id] == selected_team.id
          puts "⚠️ \e[33mHome and Away teams cannot be the same!\e[0m"
        else
          game_hash[:home_team_id] = selected_team.id
          break
        end
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
