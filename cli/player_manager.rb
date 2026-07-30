class PlayerManager
  def view_all_players
    display_banner
    puts "\n-=All Players =-"
    players = Player.all

    if players.empty?
      puts "No players founds."
    else
      players.each do |player|
        display_player(player)
        puts "=" * 50
      end
    end
  end

  def view_player
    display_banner
    puts "\n-= View Player Details =-"
    players = Player.order(:name).to_a

    players.each_with_index do |player, index|
      puts "#{index + 1}. #{player.name}"
    end
    loop do
      print "\nEnter the number of the player you wish to view: "
      choice = gets.chomp

      player = if choice.match?(/\A\d+\z/) && choice.to_i.between?(1, players.size)
                 players[choice.to_i - 1]
               end

      if player
        display_banner
        puts "\n-= View Player Details =-"
        puts "\n#{player.name} (ID #{player.id})"
        puts "Current Team: #{player.team&.name || "\e[3mNo team\e[0m"}"
        puts "Rating: #{player.total_skill}"
        puts "Player Stats"
        puts "├─ Batting:  #{'💥' * player.batting} (#{player.batting})"
        puts "├─ Running:  #{'👟' * player.running} (#{player.running})"
        puts "├─ Pitching: #{'⚾' * player.pitching} (#{player.pitching})"
        puts "└─ Fielding: #{'🏟️' * player.fielding} (#{player.fielding})"
        break
      else
        puts FAILURE_MESSAGE
      end
    end
  end

  def create_player
    display_banner
    puts "\n-= Create New Player =-"
    loop do
      player_hash = prompt_player_attributes
      new_player = Player.new(player_hash)

      puts "=" * 50
      display_player(new_player)

      confirm = nil
      loop do
        print "\nDoes this look correct? (Y/N): "
        confirm = gets.chomp.upcase
        break if ['Y', 'N', 'YES', 'NO'].include?(confirm)

        puts FAILURE_MESSAGE
      end

      if ['Y', 'YES'].include?(confirm)
        puts "\n\e[3;32mSaved #{new_player.name} to database....\e[0m"
        new_player.save
        break
      else
        puts "\e[3mRestarting form input....\e[0m\n"
      end
    end
  end

  def update_player
    display_banner
    puts "\n-= Update Player =-"
    players = Player.order(:name).to_a

    players.each_with_index do |player, index|
      puts "#{index + 1}. #{player.name}"
    end
    loop do
      print "\nEnter the number of the player you wish to update: "
      choice = gets.chomp

      player = if choice.match?(/\A\d+\z/) && choice.to_i.between?(1, players.size)
                 players[choice.to_i - 1]
               end

      if player
        display_player(player)
        puts "=" * 50
        loop do
          player_hash = prompt_player_attributes(player)
          player.assign_attributes(player_hash)

          puts "=" * 50
          display_player(player)

          confirm = nil
          loop do
            print "\nSave these changes? (Y/N): "
            confirm = gets.chomp.upcase
            break if ['Y', 'N', 'YES', 'NO'].include?(confirm)

            puts FAILURE_MESSAGE
          end

          if ['Y', 'YES'].include?(confirm)
            puts "\n\e[3;32mSaved changes....\e[0m"
            player.save
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

  def delete_player
    display_banner
    puts "\n-= Delete Player =-"
    players = Player.order(:name).to_a

    players.each_with_index do |player, index|
      puts "#{index + 1}. #{player.name}"
    end
    loop do
      print "\nEnter the number of the player you wish to delete: "
      choice = gets.chomp

      player = if choice.match?(/\A\d+\z/) && choice.to_i.between?(1, players.size)
                 players[choice.to_i - 1]
               end

      if player
        puts "=" * 50
        display_player(player)

        confirm = nil
        loop do
          print "\n⚠️ \e[1;33mAre you sure you want to delete this player? This action cannot be undone: \e[0m"
          confirm = gets.chomp.upcase
          break if ['Y', 'N', 'YES', 'NO'].include?(confirm)

          puts FAILURE_MESSAGE
        end

        if ['Y', 'YES'].include?(confirm)
          player.destroy
          puts "\n\e[3;31mPlayer has been deleted.\e[0m"
          break
        end

        break
      else
        puts FAILURE_MESSAGE
      end
    end
  end

  private

  def display_player(player)
    puts "ID: #{player.id}" if player.id
    puts "Name: #{player.name}"
    puts "Team: #{player.team&.name || "\e[3mNo team\e[0m"}"
    puts "Attributes"
    puts "├─ Batting:  #{player.batting}"
    puts "├─ Running:  #{player.running}"
    puts "├─ Pitching: #{player.pitching}"
    puts "└─ Fielding: #{player.fielding}"
    puts "Total Skill: #{player.total_skill}"
  end

  def prompt_player_attributes(existing_player = nil)
    player_hash = {
      name: existing_player&.name,
      team_id: existing_player&.team_id,
      batting: existing_player&.batting,
      running: existing_player&.running,
      pitching: existing_player&.pitching,
      fielding: existing_player&.fielding,
    }

    loop do
      print "Enter player name#{" [#{player_hash[:name]}]" if existing_player}: "
      input = gets.chomp

      if input.strip.empty?
        if existing_player
          break
        else
          puts FAILURE_MESSAGE
          next
        end
      end

      player_hash[:name] = input
      break
    end

    teams = Team.all.to_a
    teams.each_with_index do |team, index|
      puts "#{index + 1}. #{team.name}"
    end

    current_team_label = player_hash[:team_id] ? Team.find(player_hash[:team_id]).name : "Free Agent"
    loop do
      print "Enter the player's team number#{" [#{current_team_label}]" if existing_player} (type 'none' for free agent): "
      input = gets.chomp
      stripped = input.strip

      if stripped.empty? && existing_player
        break
      elsif stripped.downcase == "none"
        player_hash[:team_id] = nil
        break
      elsif stripped.match?(/\A\d+\z/) && stripped.to_i.between?(1, teams.size)
        team = teams[stripped.to_i - 1]
        if team.players.where.not(id: existing_player&.id).count >= 9
          puts "\e[33mCannot have more than 9 players on a team\e[0m"
        else
          player_hash[:team_id] = team.id
          break
        end
      else
        puts FAILURE_MESSAGE
      end
    end

    puts "\nAssign player's skills (\e[3mNote: Skills must be within 0 and 10pts, total skill cannot exceed 25\e[0m)"
    puts "(press Enter to keep current value)" if existing_player
    loop do
      skill_keys = %i[batting running pitching fielding]
      skill_keys.each do |key|
        loop do
          print "Enter #{player_hash[:name]}'s #{key} skill#{" [#{player_hash[key]}]" if existing_player}: "
          input = gets.chomp

          if input.strip.empty? && existing_player
            break
          elsif (0..10).cover?(input.to_i) && input.match?(/\A\d+\z/)
            player_hash[key] = input.to_i
            break
          else
            puts FAILURE_MESSAGE
          end
        end
      end

      total = player_hash.values_at(*skill_keys).sum
      break if total <= 25

      puts "⚠️ \e[33mA player's skills cannot total more than 25. Please re-enter skills.\e[0m"
    end

    player_hash
  end
end
