# frozen_string_literal: true

puts "🌱 Seeding spices..."

# Seed your database here
# Clear existing data to prevent duplicate primary key or foreign key constraint issues
puts "Clearing old data..."
Game.delete_all
Player.delete_all
Team.delete_all

puts "Creating Backyard Baseball teams..."
# 1998 Backyard Baseball Teams (Picked from the standard custom choices)
melonheads = Team.create!(name: "Humongous Melonheads")
wombats    = Team.create!(name: "Mighty Wombats")
monsters   = Team.create!(name: "Melrose Monsters")
fishes     = Team.create!(name: "Screaming Fishes")

puts "Creating Backyard Baseball kids..."
# Custom player list with statistics capped out of 10, total_skill capped at 25.
# Format: [name, batting, running, pitching, fielding, team_object]
players_data = [
  # --- Humongous Melonheads ---
  ["Pablo Sanchez",     10, 9, 5, 8, melonheads], # The GOAT. Stats balanced to fit your 25 max total cap
  ["Achmed Khan",        9, 6, 2, 7, melonheads],
  ["Jocinda Smith",      8, 5, 4, 8, melonheads],
  
  # --- Mighty Wombats ---
  ["Pete Wheeler",       5, 10, 2, 6, wombats],    # Ultimate speed
  ["Keisha Phillips",    9, 7,  3, 6, wombats],
  ["Vicki Kawaguchi",    3, 9,  2, 9, wombats],

  # --- Melrose Monsters ---
  ["Mikey Thomas",       9, 3,  2, 5, monsters],   # Power hitter, slow runner
  ["Angela Delvecchio",  4, 3,  10, 6, monsters],  # Ace pitcher
  ["Dmitri Petrovich",   7, 5,  4, 6, monsters],

  # --- Screaming Fishes ---
  ["Stephanie Morgan",   6, 6,  3, 10, fishes],   # Star shortstop
  ["Kenny Kawaguchi",    4, 6,  8,  5, fishes],   # Wheelchair ace
  ["Luanne Lui",         3, 9,  3,  8, fishes]
]

players_data.each do |name, batting, running, pitching, fielding, team|
  # Calculate total skill and ensure it strictly caps at 25 if data adjusts
  calculated_total = batting + running + pitching + fielding
  final_total = [calculated_total, 25].min

  Player.create!(
    name: name,
    team: team,
    batting: batting,
    running: running,
    pitching: pitching,
    fielding: fielding,
    total_skill: final_total
  )
end

Player.create!(name: "Leem", batting: 9, running: 3, pitching: 4, fielding: 6, total_skill: 22)

puts "Creating sample historical games..."
# Sample matchups between the created clubs
Game.create!(
  home_team_id: melonheads.id,
  away_team_id: wombats.id,
  home_score: 7,
  away_score: 4,
  date_played: DateTime.new(2026, 7, 20, 14, 0, 0)
)

Game.create!(
  home_team_id: monsters.id,
  away_team_id: fishes.id,
  home_score: 2,
  away_score: 3,
  date_played: DateTime.new(2026, 7, 22, 16, 30, 0)
)

Game.create!(
  home_team_id: wombats.id,
  away_team_id: monsters.id,
  home_score: 11,
  away_score: 5,
  date_played: DateTime.new(2026, 7, 25, 10, 0, 0)
)

puts "Database seeded successfully!"
puts "Created #{Team.count} teams, #{Player.count} players, and #{Game.count} games."


puts "✅ Done seeding!"
