require_relative "../config/environment"

class TeamManager
  def view_all_teams
    puts "\n-=All Teams =-"
    teams = Team.all

    if teams.empty?
      puts "No teams founds."
    else
      teams.each do |team|
        display_team(team)
        puts "=" * 50
      end
    end
  end

  def view_team
    puts "\n-= View Team Details =-"
    Team.all.each do |team|
      puts "#{team.id}. #{team.name}"
    end
    puts "\e[3mNote - Numbers may skip as they are based on IDs\e[0m"
    loop do
      puts "\nEnter the ID of the team you wish to view:"
      choice = gets.chomp

      team = Team.find_by(id: choice)

      if team
        puts "\n#{team.name} (ID #{team.id})"
        puts "Record (Win/Lose/Tie): \e[32m#{team.games_won}\e[0m / \e[31m#{team.games_lost}\e[0m / \e[33m#{team.games_tied}\e[0m"
        wr_value = team.games_played.zero? ? 0.0 : (team.games_won.to_f / team.games_played) * 100
        wr = format("%.1f", wr_value)
        puts "Games Played (WR%): #{team.games_played} (#{wr}%)"
        puts "Players:"
        if team.players.empty?
          puts "  \e[3mThis team has no players.\e[0m"
        else
          team.players.each do |player|
            puts "  ID #{player.id}: #{player.name} (Rating: #{player.total_skill})"
          end
        end
        puts "Team Rating: #{team.skill}"
        puts "Most Recent Game:"
        game = team.games.order(date_played: :desc).first
        puts "  #{game ? game.date_played.strftime('%m/%d/%Y') : "\e[3mThis team hasn't played any games yet.\e[0m"}"
        game&.matchup_vs(team)
        break
      else
        puts FAILURE_MESSAGE
      end
    end
  end

  def create_team
    puts "\n-= Create New Team =-"

    loop do
      name = ""
      loop do
        puts "\nEnter your team name:"
        name = gets.chomp

        break unless name == ""
        puts "Cannot have an empty team name"
      end

      puts %(\n⚠️ \e[33mYou're about to create a team with the name "#{name}"\e[0m)
      confirm = nil
      loop do
        print "Does this look correct? (Y/N): "
        confirm = gets.chomp.upcase

        break if ['Y', 'N', 'YES', 'NO'].include?(confirm)

        puts FAILURE_MESSAGE
      end

      if ['Y', 'YES'].include?(confirm)
        puts "\n\e[3;32mSaved #{name} to database....\e[0m"
        Team.create!(name: name)
        break
      else
        puts "\e[3mRestarting form input....\e[0m"
      end
    end
  end

  def update_team
    puts "\n-= Update Team =-"

    Team.all.each do |team|
      puts "#{team.id}. #{team.name}"
    end
    puts "\e[3mNote - Numbers may skip as they are based on IDs\e[0m"

    loop do
      puts "\nEnter the ID of the team you wish to edit:"
      choice = gets.chomp

      team = Team.find_by(id: choice)

      if team
        loop do
          puts "\n#{team.name} (ID #{team.id})"
          puts "Players:"
          if team.players.empty?
            puts "  \e[3mThis team has no players.\e[0m"
          else
            team.players.each do |player|
              puts "  ID #{player.id}: #{player.name} (Rating: #{player.total_skill})"
            end
          end
          puts "\n1. Team Name"
          puts "2. Players"
          puts "q. Quit"
          puts "\n\e[3mNote: If you are trying to add/remove games to this team, you must edit the game(s) directly.\e[0m"
          puts "Select what you want to edit:"
          choice = gets.chomp.downcase

          case choice
          when "1"
            update_name(team)
          when "2"
            update_players(team.id)
          when "q", "quit", "exit"
            puts "Backing out of edit."
            break
          else
            puts FAILURE_MESSAGE
          end
        end
        break
      else
        puts FAILURE_MESSAGE
      end
    end
  end

  def delete_team
    puts "\n-= Delete A Team =-"
  end

  private

  def display_team(team)
    puts "ID: #{team.id}"
    puts "Name: #{team.name}"
    puts "Games Played: #{team.games_played}"
    puts "Games Won: #{team.games_won}"
    puts "Games Lost: #{team.games_lost}"
    puts "Games Tied: #{team.games_tied}"
    puts "Team Rating: #{team.skill}"
  end

  def update_name(team)
    loop do
      name = team.name
      loop do
        puts "Your current team name is #{team.name}"
        puts "\nEnter the new team name:"
        name = gets.chomp

        break unless name == ""

        puts "Cannot have an empty team name"
      end

      puts %(\n⚠️ \e[33mYou're about to update your team with the name "#{name}"\e[0m)
      confirm = nil
      loop do
        print "Does this look correct? (Y/N): "
        confirm = gets.chomp.upcase

        break if ['Y', 'N', 'YES', 'NO'].include?(confirm)

        puts FAILURE_MESSAGE
      end

      if ['Y', 'YES'].include?(confirm)
        puts "\n\e[3;32mSaved #{name} to database....\e[0m"
        team.update(name: name)
        break
      else
        puts "\e[3mRestarting form input....\e[0m"
      end
    end
  end

  def update_players(team_id)
    loop do
      team = Team.find(team_id)
      puts "=" * 50
      puts "\nCurrent Team Players:"
      if team.players.empty?
        puts "  \e[3mThis team has no players.\e[0m"
      else
        team.players.each do |player|
          puts "  ID #{player.id}: #{player.name} (Rating: #{player.total_skill})"
        end
      end

      puts "\nCurrent Free Agents:"
      free_agents = Player.where(team_id: nil)
      if free_agents.empty?
        puts "  \e[3mThere are currently no free agents.\e[0m"
      else
        free_agents.each do |player|
          puts "  ID #{player.id}: #{player.name} (Rating: #{player.total_skill})"
        end
      end

      puts "Enter the ID of the player you want to add or remove from the team. Type quit when you're finished:"
      choice = gets.chomp.downcase

      break if ["quit", "q"].include?(choice)

      picked_player = Player.find_by(id: choice)

      if picked_player
        if picked_player.team_id == team.id
          picked_player.team_id = nil
          puts "\e[31m#{picked_player.name} has been removed\e[0m"
        elsif team.players.count >= 9
          puts "\e[33mCannot have more than 9 players on a team\e[0m"
        elsif picked_player.team_id.nil?
          picked_player.team_id = team.id
          puts "\e[32m#{picked_player.name} has been added\e[0m"
        else
          puts FAILURE_MESSAGE
        end
        picked_player.save
      else
        puts FAILURE_MESSAGE
      end
    end
  end
end
