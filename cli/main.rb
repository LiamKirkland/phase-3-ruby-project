#!/usr/bin/env ruby

require_relative "../config/environment"
require_relative "team_manager"
require_relative "game_manager"
require_relative "player_manager"

class BackyardBaseball
  def initialize
    @tm = TeamManager.new
    @gm = GameManager.new
    @pm = PlayerManager.new
  end

  def display_main_menu
    display_banner
    puts "\n-= Backyard Baseball =-"
    puts "1. Team Management"
    puts "2. Game Management"
    puts "3. Player Management"
    puts "4. Simulate a Game"
    puts "q. Quit"
    print "\nMake your selection: "
  end

  def run
    puts "Welcome to Backyard Baseball!"
    puts

    loop do
      display_main_menu
      choice = gets.chomp.downcase

      case choice
      when "1" then team_menu
      when "2" then game_menu
      when "3" then player_menu
      when "4" then simulate_game
      when "q", "quit", "exit"
        display_goodbye
        break
      end
    end
  end

  private

  def team_menu
    loop do
      display_banner
      puts "\n-= Team Management =-"
      puts "1. View All Teams"
      puts "2. View Team Details"
      puts "3. Add a New Team"
      puts "4. Update a Team"
      puts "5. Delete a Team"
      puts "b. Back to Main Menu"
      print "\nMake your selection: "

      choice = gets.chomp.downcase

      case choice
      when "1"
        @tm.view_all_teams
        pause
      when "2"
        @tm.view_team
        pause
      when "3" then @tm.create_team
      when "4" then @tm.update_team
      when "5" then @tm.delete_team
      when "b", "back"
        break
      end
    end
  end

  def game_menu
    loop do
      display_banner
      puts "\n-= Game Management =-"
      puts "1. View All Games"
      puts "2. View Game Details"
      puts "3. Add a New Game"
      puts "4. Update a Game"
      puts "5. Delete a Game"
      puts "b. Back to Main Menu"
      print "\nMake your selection: "

      choice = gets.chomp.downcase

      case choice
      when "1"
        @gm.view_all_games
        pause
      when "2"
        @gm.view_game
        pause
      when "3" then @gm.create_game
      when "4" then @gm.update_game
      when "5" then @gm.delete_game
      when "b", "back"
        break
      end
    end
  end

  def player_menu
    loop do
      display_banner
      puts "\n-= Player Management =-"
      puts "1. View All Players"
      puts "2. View Player Details"
      puts "3. Add a New Player"
      puts "4. Update a Player"
      puts "5. Delete a Player"
      puts "b. Back to Main Menu"
      print "\nMake your selection: "

      choice = gets.chomp.downcase

      case choice
      when "1"
        @pm.view_all_players
        pause
      when "2"
        @pm.view_player
        pause
      when "3" then @pm.create_player
      when "4" then @pm.update_player
      when "5" then @pm.delete_player
      when "b", "back"
        break
      end
    end
  end

  def simulate_game
    display_banner
    puts "\n-= Simulate Game =-"

    game_hash = {
      away_team_id: nil,
      home_team_id: nil,
      away_score: nil,
      home_score: nil,
      date_played: Date.today,
    }

    puts "Pick the \e[38;5;214mAway\e[0m and \e[36mHome\e[0m teams"
    teams = Team.all.to_a
    teams.each_with_index do |team, index|
      puts "#{index + 1}. #{team.name} (Rating: #{team.skill})"
    end

    puts "\nEnter the team's number to select them"

    loop do
      print "\e[38;5;214mAway Team: \e[0m"
      input = gets.chomp

      if input.match?(/\A\d+\z/) && input.to_i.between?(1, teams.size)
        game_hash[:away_team_id] = teams[input.to_i - 1].id
        game_hash[:away_team_name] = teams[input.to_i - 1].name
        break
      else
        puts FAILURE_MESSAGE
      end
    end

    loop do
      print "\e[36mHome Team: \e[0m"
      input = gets.chomp

      if input.match?(/\A\d+\z/) && input.to_i.between?(1, teams.size)
        selected_team = teams[input.to_i - 1]
        if game_hash[:away_team_id] == selected_team.id
          puts "⚠️ \e[33mHome and Away teams cannot be the same!\e[0m"
        else
          game_hash[:home_team_id] = selected_team.id
          game_hash[:home_team_name] = teams[input.to_i - 1].name
          break
        end
      else
        puts FAILURE_MESSAGE
      end
    end
    home_team = Team.find(game_hash[:home_team_id])
    away_team = Team.find(game_hash[:away_team_id])

    game_events = [
      build_event(" hits a home run!", home_team, away_team, :batting, true),
      build_event(" hits a pop fly... and it gets caught. OUT!", home_team, away_team, :batting, false),
      build_event(" catches a pop fly.", home_team, away_team, :fielding, true),
      build_event(" hits the batter, they get walked.", home_team, away_team, :pitching, false),
      build_event(" steals 3rd base!", home_team, away_team, :running, true),
      build_event(" drops a pop fly.", home_team, away_team, :fielding, false),
      build_event(" makes a double play.", home_team, away_team, :batting, false),
      build_event(" almost drops the ball!", home_team, away_team, :batting, false),
      build_event(" bunts the ball and barely makes it to first.", home_team, away_team, :batting, true),
      build_event(" hits a foul ball.", home_team, away_team, :batting, false),
      build_event(" strikes out swinging.", home_team, away_team, :batting, false),
      build_event(" slides into home just in time!", home_team, away_team, :running, true),
      build_event(" makes a diving catch in the outfield!", home_team, away_team, :fielding, true),
      build_event(" walks the batter on four straight balls.", home_team, away_team, :pitching, false),
      build_event(" beats the throw to first by a step!", home_team, away_team, :running, true),
      build_event(" overthrows first base, the ball sails into the stands.", home_team, away_team, :fielding, false),
      build_event(" throws a curveball for strike three!", home_team, away_team, :pitching, true),
      build_event(" gets caught trying to steal second, OUT!", home_team, away_team, :running, false),
      build_event(" watches strike three sail right by.", home_team, away_team, :batting, false),
      build_event(" swings at the air, strike three!", home_team, away_team, :batting, false),
      build_event(" gets obliterated by a falling meteor.", home_team, away_team, :batting, false),
    ]

    display_banner
    puts "\n-= Simulate Game =-"
    puts "Simulating \e[38;5;214m#{away_team.name}\e[0m v. \e[36m#{home_team.name}\e[0m..."
    puts
    game_events.sample(7).each do |event|
      puts event[:text]
      if event[:text].include?("meteor")
        player = event[:player]
        sleep 1.5
        puts "\e[3;31mDeleted #{player.name} from the database...\e[0m"
        player.destroy
      end
      sleep 1.5
    end

    final_scores = simulate_and_display_result(home_team, away_team)
    game_hash[:away_score] = final_scores[:away_score]
    game_hash[:home_score] = final_scores[:home_score]
    game_hash[:home_star] = home_team.players.max_by(&:total_skill).name
    game_hash[:away_star] = away_team.players.max_by(&:total_skill).name
    Game.create(game_hash)
    pause
  end

  def event_gen(home, away, stat, success)
    team, color = [[home, "\e[36m"], [away, "\e[38;5;214m"]].sample
    player = if success
               team.players.max_by(&stat)
             else
               team.players.sample
             end
    ["#{color}#{player.name}\e[0m", player]
  end

  def build_event(text_template, home, away, stat, success)
    name, player = event_gen(home, away, stat, success)
    { text: "#{name}#{text_template}", player: player }
  end

  def simulate_and_display_result(home_team, away_team, k = 0.03)
    skill_diff = home_team.skill - away_team.skill
    home_win_chance = 1.0 / (1 + Math.exp(-k * skill_diff))

    home_wins = rand < home_win_chance
    winner = home_wins ? home_team : away_team
    winner_color = home_wins ? "\e[36m" : "\e[38;5;214m"

    winner_score = rand(4..12)
    loser_score = rand(0..(winner_score - 1))

    home_score = home_wins ? winner_score : loser_score
    away_score = home_wins ? loser_score : winner_score

    mvp = winner.players.max_by(&:total_skill)
    mvp_line = mvp ? "#{mvp.name} (Rating: #{mvp.total_skill})" : "\e[3mNo players on roster\e[0m"

    underdog_won = (home_wins && home_team.skill < away_team.skill) ||
                   (!home_wins && away_team.skill < home_team.skill)
    skill_gap = (home_team.skill - away_team.skill).abs

    puts "\n#{'=' * 50}"
    puts "\e[1mFinal Score:\e[0m \e[36m#{home_team.name} (Rating: #{home_team.skill})\e[0m #{home_score} - #{away_score} \e[38;5;214m#{away_team.name} (Rating: #{away_team.skill})\e[0m"
    puts "\e[1mWinner:\e[0m #{winner_color}#{winner.name}\e[0m"
    puts "\e[1mMVP:\e[0m #{winner_color}#{mvp_line}\e[0m"

    if underdog_won && skill_gap >= 30
      puts "\n🎉 \e[33mUPSET!\e[0m #{winner.name} pulls off a stunning win despite being the underdogs!"
    end

    puts "=" * 50

    { home_score: home_score, away_score: away_score }
  end

  def display_goodbye
    art_lines = <<~ART.lines
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡤⠴⠒⠤⣄⡀⠀⠀⠀⠀⢠⣾⠉⠉⠉⠉⠑⠒⠦⢄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⠋⠀⠀⠀⠀⠀⠉⠲⡄⠀⢠⠏⡏⠀⠀⠀⠀⠀⠀⠀⠀⠉⠳⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⢤⣤⣀⡀⠀⠀⠀⠀⠀⢰⡏⠀⠀⠀⠀⠀⠀⠀⠀⠘⢆⢸⠀⡇⠀⠀⠀⢀⣀⠀⠀⠀⠀⠀⢸⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⠏⠀⠀⠀⠀⠈⠙⠢⣄⠀⠀⣿⠀⠀⠀⢰⣿⣷⣆⠀⠀⠀⠘⣾⠀⠇⠀⠀⠀⣿⣿⣿⣦⠀⠀⠀⠀⢻⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⢀⣀⡤⣄⠀⠀⠀⣼⡇⠀⠀⠀⢀⣀⠀⠀⠀⠈⠳⣴⢿⡄⠀⠀⢸⣿⣿⣿⠀⠀⠀⠀⣿⠀⡆⠀⠀⠀⣿⣿⣿⣿⠀⠀⠀⠀⣸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⠀⢀⡴⠚⠉⠀⠀⠈⠳⡄⠀⣿⡇⠀⠀⠀⣿⣿⣿⡄⠀⠀⠀⢹⣆⢧⠀⠀⠀⠙⠿⠋⠀⠀⠀⠀⣿⠀⡇⠀⠀⠀⠙⠛⠉⠁⠀⠀⠀⢠⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⠀⢠⠟⠀⠀⠀⠀⢀⣤⣾⣷⣀⡇⢣⠀⠀⠀⢻⣿⣿⣷⠀⠀⠀⠈⣿⣾⣆⠀⠀⠀⠀⠀⠀⠀⠀⣸⢿⢰⡁⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡾⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⣠⡏⠀⠀⠀⣼⣿⣿⣿⡿⠛⠉⢻⣞⣧⠀⠀⠀⠉⠛⠁⠀⠀⠀⠀⡿⣿⣿⣦⣀⠀⠀⠀⠀⣠⣾⡏⢸⣠⣧⣤⣄⣤⣤⣤⣤⣤⣴⣾⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⣿⠀⠀⠀⢸⣿⣿⠛⠁⠀⠀⠀⠀⠻⣯⣷⣄⠀⠀⠀⠀⠀⠀⢀⣼⠁⠘⠿⣿⣿⣻⣿⣿⣿⣿⠏⠀⣾⣿⣿⣿⣿⣿⣿⣿⡿⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
      ⣿⣇⠀⠀⠈⢿⣿⢧⣴⣶⡆⠀⠀⠀⢿⣿⣿⢳⢦⣤⣤⣤⣶⣿⠟⠀⠀⠀⠀⠉⠉⠛⠋⢩⡤⠖⠒⠛⠛⡿⢁⣾⠋⠉⠉⠉⠉⠉⠉⠉⠉⠉⠉⣷⠀⠀⠀⠀⢀⣤⠤⠤⣀⡀⠀
      ⣿⣿⣆⠀⠀⠀⠙⠻⠿⠛⠃⠀⠀⠀⣸⡙⠻⢿⣿⣿⣿⣿⠿⠋⠀⣀⡤⠤⠒⠚⠳⣄⢠⣿⠁⠀⠀⠀⢠⠇⡏⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⢀⡴⢫⡇⠀⠀⠀⠈⠙
      ⠘⣿⣿⣷⣄⡀⠀⠀⠀⠀⠀⠀⣀⣼⣿⠇⠀⠀⠀⣀⣀⣀⠀⢀⣼⣿⣦⡀⠀⠀⠀⠈⢻⡏⠀⠀⠀⠀⡞⠀⡇⢸⠀⠀⠀⠀⢰⣶⣶⣶⣶⣶⣶⡏⠀⠀⡼⠀⡞⠀⠀⠀⠀⠀⢸
      ⠀⠈⠻⣿⣿⣿⣶⢶⡶⡶⣶⣾⣿⡿⠋⣠⠴⠚⠉⠁⠀⠉⠙⠺⡿⢿⣿⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⣸⠃⢰⠀⢸⠀⠀⠀⠀⠘⠛⠛⠿⠿⢿⡏⠀⠀⢰⠃⢠⠇⠀⠀⠀⠀ ⢸
      ⠀⠀⠀⠈⠙⠻⠿⠼⠽⠿⠿⠟⠋⢰⡟⠁⠀⠀⢀⣤⣄⡀⠀⠀⠹⡆⠙⢿⣿⣿⣦⡀⠀⠀⠀⠀⢰⡇⠀⢸⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⡞⠀⡜⠀⠀⠀⠀⠀ ⢸
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡾⢳⡀⠀⠀⠈⢿⡿⠇⠀⠀⣼⠃⠀⠀⠙⢿⣿⣿⣷⠀⠀⠀⠈⡇⠀⢸⠀⡄⠀⠀⠀⠀⢰⣶⣤⣤⣤⣼⠃⠀⢰⠃⢰⠃⠀⠀⠀⠀⠀ ⢸
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢷⠀⢣⠀⠀⠀⠀⠀⠀⠀⠈⠋⠉⠲⣄⠀⠀⠙⢿⠸⡄⠀⠀⠀⢳⠀⢸⠀⡇⠀⠀⠀⠀⠸⣿⣿⣿⣿⣃⠀⠀⣞⣠⣾⣤⣀⣀⣀⣀⣀⣀⡞
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣆⠈⣇⠀⠀⠀⠀⣠⣤⣀⠀⠀⠀⠘⣆⠀⠀⠸⡄⢳⠀⠀⠀⠸⡆⢸⠀⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⠀⠘⠻⢿⣿⣿⣿⣿⡿⠟⠁⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⡆⠘⡄⠀⠀⠀⢻⣿⣿⠆⠀⠀⠀⢸⠀⠀⠀⣇⠘⡆⠀⢀⣀⣧⢸⢀⣿⣶⣤⣤⣤⣀⣀⣀⠀⢀⡏⠀⢀⣴⠟⠁⠀⠀⠈⢳⡀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⡄⠹⡄⠀⠀⠈⠉⠁⠀⠀⠀⣠⡾⠀⠀⠀⢹⢀⣿⣿⣿⡿⠃⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⢰⣯⡏⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢳⠀⠹⡄⠀⠀⠀⢀⣠⣴⣾⣿⠃⠀⠀⠀⠘⠿⠟⠛⠛⠁⠀⠀⠀⠉⠉⠉⠛⠛⠛⠿⠟⠁⠀⠀⢾⣿⣷⣄⡀⠀⠀⢀⡼⠃⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢧⠀⢳⣴⣶⣿⣿⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣿⣿⡿⠟⠁⠀⠀⠀⠀
      ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣦⣿⣿⡿⠟⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀
    ART

    colors = ["\e[31m", "\e[38;5;208m", "\e[33m", "\e[32m", "\e[36m", "\e[34m", "\e[35m"]

    art_lines.each_with_index do |line, index|
      puts "#{colors[index % colors.size]}#{line.chomp}\e[0m"
    end
  end
end

BackyardBaseball.new.run if __FILE__ == $PROGRAM_NAME
