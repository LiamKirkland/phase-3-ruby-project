class PlayerManager
  def view_all_players
    puts "-=All Players =-"
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
    puts "\n-= View Player Details =-"
    Player.all.each do |player|
      puts "#{player.id}. #{player.name}"
    end
    puts "\e[3mNote - Numbers may skip as they are based on IDs\e[0m"
    loop do
      puts "\nEnter the ID of the player you wish to view:"
      choice = gets.chomp

      player = Player.find_by(id: choice)

      if player
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

  private

  def display_player(player)
    puts "ID: #{player.id}"
    puts "Name: #{player.name}"
    puts "Team: #{player.team&.name || "\e[3mNo team\e[0m"}"
    puts "Attributes"
    puts "├─ Batting:  #{player.batting}"
    puts "├─ Running:  #{player.running}"
    puts "├─ Pitching: #{player.pitching}"
    puts "└─ Fielding: #{player.fielding}"
    puts "Total Skill: #{player.total_skill}"
  end
end
