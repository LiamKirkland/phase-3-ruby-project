# db/seeds.rb

Game.destroy_all
Player.destroy_all
Team.destroy_all

teams = Team.create!([
  { name: "Sunnyside Sluggers" },
  { name: "Southside Sneakers" },
  { name: "Bayview Bandits" },
])

sluggers = teams[0]
sneakers = teams[1]
bandits = teams[2]

Player.create!([
  # Sunnyside Sluggers (9 players)
  { name: "Pablo Sanchez",       team: sluggers, batting: 9, running: 8, pitching: 4, fielding: 4 },
  { name: "Pete Wheeler",        team: sluggers, batting: 8, running: 5, pitching: 5, fielding: 6 },
  { name: "Kenny Kawaguchi",     team: sluggers, batting: 3, running: 4, pitching: 9, fielding: 8 },
  { name: "Kiesha Phillips",     team: sluggers, batting: 6, running: 9, pitching: 3, fielding: 5 },
  { name: "Vicki Vanderwoozle",  team: sluggers, batting: 4, running: 3, pitching: 2, fielding: 9 },
  { name: "Timmy Lupus",         team: sluggers, batting: 1, running: 2, pitching: 1, fielding: 3 },
  { name: "Stephanie Morgan",    team: sluggers, batting: 7, running: 6, pitching: 4, fielding: 6 },
  { name: "Sally Dobbs",         team: sluggers, batting: 5, running: 5, pitching: 5, fielding: 5 },
  { name: "Dimitri Petrovic",    team: sluggers, batting: 6, running: 4, pitching: 8, fielding: 4 },

  # Southside Sneakers (9 players)
  { name: "Reese Worthington",   team: sneakers, batting: 7, running: 5, pitching: 3, fielding: 7 },
  { name: "Tony Delvecchio",     team: sneakers, batting: 8, running: 6, pitching: 5, fielding: 5 },
  { name: "Mikey Thomas",        team: sneakers, batting: 4, running: 6, pitching: 3, fielding: 5 },
  { name: "Amir Khan",           team: sneakers, batting: 6, running: 7, pitching: 6, fielding: 4 },
  { name: "Achmed Khan",         team: sneakers, batting: 3, running: 4, pitching: 9, fielding: 7 },
  { name: "Egghead",             team: sneakers, batting: 2, running: 1, pitching: 2, fielding: 4 },
  { name: "Freddy Fernandez",    team: sneakers, batting: 5, running: 8, pitching: 4, fielding: 6 },
  { name: "Lisa Crocket",        team: sneakers, batting: 6, running: 5, pitching: 4, fielding: 8 },
  { name: "Gretchen Hasslein",   team: sneakers, batting: 7, running: 4, pitching: 6, fielding: 5 },

  # Bayview Bandits (6 players, under the 9 max)
  { name: "Ronaldo Devers",      team: bandits, batting: 8, running: 7, pitching: 4, fielding: 3 },
  { name: "Maria Luna",          team: bandits, batting: 5, running: 5, pitching: 7, fielding: 6 },
  { name: "Jorge Garcia",        team: bandits, batting: 6, running: 6, pitching: 6, fielding: 6 },
  { name: "Danny Rodriguez",     team: bandits, batting: 4, running: 9, pitching: 2, fielding: 8 },
  { name: "Keiko Ando",          team: bandits, batting: 7, running: 4, pitching: 8, fielding: 5 },
  { name: "Pumpkin Marchetti",   team: bandits, batting: 3, running: 3, pitching: 5, fielding: 9 },

  # Free agents (no team)
  { name: "Angela Delvecchio",   team: nil, batting: 6, running: 6, pitching: 5, fielding: 6 },
  { name: "Harold Chen",         team: nil, batting: 4, running: 5, pitching: 7, fielding: 6 },
  { name: "Bea Spivey",          team: nil, batting: 5, running: 5, pitching: 5, fielding: 5 },
])

Game.create!([
  {
    home_team: sluggers,
    away_team: sneakers,
    home_score: 7,
    away_score: 4,
    date_played: DateTime.new(2026, 6, 12),
  },
  {
    home_team: bandits,
    away_team: sluggers,
    home_score: 3,
    away_score: 9,
    date_played: DateTime.new(2026, 6, 19),
  },
  {
    home_team: sneakers,
    away_team: bandits,
    home_score: 5,
    away_score: 5,
    date_played: DateTime.new(2026, 6, 26),
  },
])

puts "Seeded #{Team.count} teams, #{Player.count} players (#{Player.where(team_id: nil).count} free agents), and #{Game.count} games."