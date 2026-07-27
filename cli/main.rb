#!/usr/bin/env ruby

require_relative "../config/environment"

class BackyardBaseball
  def display_menu
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
      when "1" then puts "You chose 1"
      when "2" then puts "You chose 2"
      when "3" then puts "You chose 3"
      when "4" then puts "You chose 4"
      when "5" then puts "You chose 5"
      when "6" then puts "You chose 6"
      when "7" then puts "You chose 7"
      when "8" then puts "You chose 8"
      when "9" then puts "You chose 9"
      when "0" then puts "You chose 0"
      when "a" then puts "You chose a"
      when "b" then puts "You chose b"
      when "c" then puts "You chose c"
      when "d" then puts "You chose d"
      when "e" then puts "You chose e"
      when "q", "quit", "exit"
        puts "Goodbye!"
        break
      else
        puts "Invalid choice. Please try again."
      end
    end
  end
end

BackyardBaseball.new.run if __FILE__ == $PROGRAM_NAME
