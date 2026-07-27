class TeamManager
  def view_all_teams
    puts "-=All Teams =-"
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
        puts "#{team.name} (ID #{team.id})"
        puts "Record (Win/Lose/Tie): \e[32m#{team.games_won}\e[0m / \e[31m#{team.games_lost}\e[0m / \e[33m#{team.games_tied}\e[0m"
        wr = format("%.1f", (team.games_won.to_f / team.games_played) * 100)
        puts "Games Played (WR%): #{team.games_played} (#{wr}%)"
        puts "Players:"
        team.players.each do |player|
          puts "  ID #{player.id}: #{player.name} (Rating: #{player.total_skill})"
        end

        puts "Most Recent Game:"
        game = team.games.order(date_played: :desc).first
        puts "  #{game.date_played.strftime('%m/%d/%Y')}"
        game.matchup_vs(team)
        break
      else
        puts FAILURE_MESSAGE
      end
    end
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
end
