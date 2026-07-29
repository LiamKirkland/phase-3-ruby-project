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
    puts "\n-= Backyard Baseball =-"
    puts "1. Team Management"
    puts "2. Game Management"
    puts "3. Player Management"
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
      when "q", "quit", "exit"
        puts "Goodbye!"
        break
      else
        puts FAILURE_MESSAGE
      end
    end
  end

  private

  def team_menu
    loop do
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
      when "1" then @tm.view_all_teams
      when "2" then @tm.view_team
      when "3" then @tm.create_team
      when "4" then @tm.update_team
      when "5" then @tm.delete_team
      when "b", "back"
        break
      else
        puts FAILURE_MESSAGE
      end
    end
  end

  def game_menu
    loop do
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
      when "1" then @gm.view_all_games
      when "2" then @gm.view_game
      when "3" then @gm.create_game
      when "4" then @gm.update_game
      when "5" then @gm.delete_game
      when "b", "back"
        break
      else
        puts FAILURE_MESSAGE
      end
    end
  end

  def player_menu
    loop do
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
      when "1" then @pm.view_all_players
      when "2" then @pm.view_player
      when "3" then @pm.create_player
      when "4" then @pm.update_player
      when "5" then @pm.delete_player
      when "b", "back"
        break
      else
        puts FAILURE_MESSAGE
      end
    end
  end
end

BackyardBaseball.new.run if __FILE__ == $PROGRAM_NAME
