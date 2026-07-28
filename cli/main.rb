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

  def display_menu
    puts "\n-= Backyard Baseball =-"
    puts "1. View All Teams"
    puts "2. View All Games"
    puts "3. View All Players"
    puts "4. Add a new team"
    puts "5. Add a new game"
    puts "6. Add a new player"
    puts "7. Update a team"
    puts "8. Update a game"
    puts "9. Update a player"
    puts "0. Delete a team"
    puts "a. Delete a game"
    puts "b. Delete a player"
    puts "c. View Team Details"
    puts "d. View Game Details"
    puts "e. View Player Details"
    puts "q. Quit"
    puts "\nMake your selection: "
  end

  def run
    puts "Welcome to Backyard Baseball!"
    puts

    loop do
      display_menu
      choice = gets.chomp.downcase

      case choice
      when "1" then @tm.view_all_teams
      when "2" then @gm.view_all_games
      when "3" then @pm.view_all_players
      when "4" then @tm.create_team
      when "5" then @gm.create_game
      when "6" then puts "You chose 6"
      when "7" then @tm.update_team
      when "8" then @gm.update_game
      when "9" then puts "You chose 9"
      when "0" then puts "You chose 0"
      when "a" then puts "You chose a"
      when "b" then puts "You chose b"
      when "c" then @tm.view_team
      when "d" then @gm.view_game
      when "e" then @pm.view_player
      when "q", "quit", "exit"
        puts "Goodbye!"
        break
      else
        puts FAILURE_MESSAGE
      end
    end
  end

  # private
end

BackyardBaseball.new.run if __FILE__ == $PROGRAM_NAME
