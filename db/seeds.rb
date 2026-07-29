# db/seeds.rb

Game.destroy_all
Player.destroy_all
Team.destroy_all

teams = Team.create!([
  { name: "Humongous Melonheads" },
  { name: "Junkyard Dogs" },
  { name: "Riverside Bandits" },
  { name: "Oakwood Renegades" },
  { name: "Cedar Grove Vipers" },
  { name: "Maple Street Comets" },
])

melonheads, dogs, bandits, renegades, vipers, comets = teams

Player.create!([
  # Humongous Melonheads (9 players)
  { name: "Pablo Sanchez",       team: melonheads, batting: 9, running: 8, pitching: 4, fielding: 4 },
  { name: "Kenny Kawaguchi",     team: melonheads, batting: 3, running: 4, pitching: 9, fielding: 8 },
  { name: "Kiesha Phillips",     team: melonheads, batting: 6, running: 9, pitching: 3, fielding: 5 },
  { name: "Timmy Lupus",         team: melonheads, batting: 1, running: 2, pitching: 1, fielding: 3 },
  { name: "Vicki Vanderwoozle",  team: melonheads, batting: 4, running: 3, pitching: 2, fielding: 9 },
  { name: "Stephanie Morgan",    team: melonheads, batting: 7, running: 6, pitching: 4, fielding: 6 },
  { name: "Sally Dobbs",         team: melonheads, batting: 5, running: 5, pitching: 5, fielding: 5 },
  { name: "Dimitri Petrovic",    team: melonheads, batting: 6, running: 4, pitching: 8, fielding: 4 },
  { name: "Pete Wheeler",        team: melonheads, batting: 8, running: 5, pitching: 5, fielding: 6 },

  # Junkyard Dogs (9 players)
  { name: "Rusty Cogsworth",     team: dogs, batting: 6, running: 6, pitching: 6, fielding: 4 },
  { name: "Scrappy Alvarez",     team: dogs, batting: 4, running: 9, pitching: 2, fielding: 6 },
  { name: "Winnie Duval",        team: dogs, batting: 7, running: 4, pitching: 5, fielding: 6 },
  { name: "Otis Beaumont",       team: dogs, batting: 3, running: 3, pitching: 9, fielding: 7 },
  { name: "Junebug Farrell",     team: dogs, batting: 8, running: 5, pitching: 3, fielding: 5 },
  { name: "Egghead",             team: dogs, batting: 2, running: 1, pitching: 2, fielding: 4 },
  { name: "Freddy Fernandez",    team: dogs, batting: 5, running: 8, pitching: 4, fielding: 6 },
  { name: "Mikey Thomas",        team: dogs, batting: 4, running: 6, pitching: 3, fielding: 5 },
  { name: "Amir Khan",           team: dogs, batting: 6, running: 7, pitching: 6, fielding: 4 },

  # Riverside Bandits (7 players)
  { name: "Ronaldo Devers",      team: bandits, batting: 8, running: 7, pitching: 4, fielding: 3 },
  { name: "Maria Luna",          team: bandits, batting: 5, running: 5, pitching: 7, fielding: 6 },
  { name: "Jorge Garcia",        team: bandits, batting: 6, running: 6, pitching: 6, fielding: 6 },
  { name: "Danny Rodriguez",     team: bandits, batting: 4, running: 9, pitching: 2, fielding: 8 },
  { name: "Keiko Ando",          team: bandits, batting: 7, running: 4, pitching: 8, fielding: 5 },
  { name: "Pumpkin Marchetti",   team: bandits, batting: 3, running: 3, pitching: 5, fielding: 9 },
  { name: "Gretchen Hasslein",   team: bandits, batting: 7, running: 4, pitching: 6, fielding: 5 },

  # Oakwood Renegades (6 players)
  { name: "Captain Redbeard",    team: renegades, batting: 7, running: 3, pitching: 6, fielding: 5 },
  { name: "Nell Ocheltree",      team: renegades, batting: 5, running: 8, pitching: 3, fielding: 6 },
  { name: "Owen Marsh",          team: renegades, batting: 4, running: 4, pitching: 8, fielding: 7 },
  { name: "Priya Anand",         team: renegades, batting: 8, running: 6, pitching: 4, fielding: 4 },
  { name: "Tobias Wren",         team: renegades, batting: 3, running: 5, pitching: 5, fielding: 9 },
  { name: "Isla Fontaine",       team: renegades, batting: 6, running: 7, pitching: 5, fielding: 5 },

  # Cedar Grove Vipers (8 players)
  { name: "Achmed Khan",         team: vipers, batting: 3, running: 4, pitching: 9, fielding: 7 },
  { name: "Lisa Crocket",        team: vipers, batting: 6, running: 5, pitching: 4, fielding: 8 },
  { name: "Reese Worthington",   team: vipers, batting: 7, running: 5, pitching: 3, fielding: 7 },
  { name: "Tony Delvecchio",     team: vipers, batting: 8, running: 6, pitching: 5, fielding: 5 },
  { name: "Bartholomew Cruz",    team: vipers, batting: 5, running: 5, pitching: 6, fielding: 6 },
  { name: "Nadia Volkov",        team: vipers, batting: 4, running: 7, pitching: 5, fielding: 6 },
  { name: "Desmond Okafor",      team: vipers, batting: 6, running: 4, pitching: 7, fielding: 5 },
  { name: "Willow Hartley",      team: vipers, batting: 3, running: 6, pitching: 4, fielding: 9 },

  # Maple Street Comets (5 players)
  { name: "Felix Marsh",         team: comets, batting: 7, running: 6, pitching: 5, fielding: 4 },
  { name: "Georgia Pruitt",      team: comets, batting: 5, running: 5, pitching: 5, fielding: 5 },
  { name: "Miles Okonkwo",       team: comets, batting: 4, running: 8, pitching: 3, fielding: 6 },
  { name: "Sofia Reyes",         team: comets, batting: 6, running: 4, pitching: 6, fielding: 6 },
  { name: "Cormac Delaney",      team: comets, batting: 3, running: 3, pitching: 8, fielding: 8 },

  # Free agents
  { name: "Angela Delvecchio",   team: nil, batting: 6, running: 6, pitching: 5, fielding: 6 },
  { name: "Harold Chen",         team: nil, batting: 4, running: 5, pitching: 7, fielding: 6 },
  { name: "Bea Spivey",          team: nil, batting: 5, running: 5, pitching: 5, fielding: 5 },
])

Game.create!([
  # Round-robin (5 games per team)
  { home_team: melonheads, away_team: dogs,      home_score: 7, away_score: 4, date_played: Date.new(2026, 4, 4) },
  { home_team: bandits,    away_team: melonheads, home_score: 3, away_score: 9, date_played: Date.new(2026, 4, 11) },
  { home_team: melonheads, away_team: renegades,  home_score: 6, away_score: 6, date_played: Date.new(2026, 4, 18) },
  { home_team: vipers,     away_team: melonheads, home_score: 2, away_score: 8, date_played: Date.new(2026, 4, 25) },
  { home_team: melonheads, away_team: comets,     home_score: 5, away_score: 4, date_played: Date.new(2026, 5, 2) },
  { home_team: dogs,       away_team: bandits,    home_score: 5, away_score: 5, date_played: Date.new(2026, 5, 9) },
  { home_team: renegades,  away_team: dogs,       home_score: 3, away_score: 7, date_played: Date.new(2026, 5, 16) },
  { home_team: dogs,       away_team: vipers,     home_score: 9, away_score: 2, date_played: Date.new(2026, 5, 23) },
  { home_team: dogs,       away_team: comets,     home_score: 4, away_score: 6, date_played: Date.new(2026, 5, 30) },
  { home_team: bandits,    away_team: renegades,  home_score: 6, away_score: 3, date_played: Date.new(2026, 6, 6) },
  { home_team: bandits,    away_team: vipers,     home_score: 4, away_score: 4, date_played: Date.new(2026, 6, 13) },
  { home_team: comets,     away_team: bandits,    home_score: 5, away_score: 7, date_played: Date.new(2026, 6, 20) },
  { home_team: renegades,  away_team: vipers,     home_score: 6, away_score: 5, date_played: Date.new(2026, 6, 27) },
  { home_team: comets,     away_team: renegades,  home_score: 3, away_score: 3, date_played: Date.new(2026, 7, 4) },
  { home_team: vipers,     away_team: comets,     home_score: 8, away_score: 6, date_played: Date.new(2026, 7, 11) },

  # Rematches (1 extra game per team)
  { home_team: dogs,       away_team: melonheads, home_score: 5, away_score: 5, date_played: Date.new(2026, 7, 18) },
  { home_team: renegades,  away_team: bandits,    home_score: 7, away_score: 8, date_played: Date.new(2026, 7, 22) },
  { home_team: comets,     away_team: vipers,     home_score: 4, away_score: 9, date_played: Date.new(2026, 7, 26) },
])

puts "Seeded #{Team.count} teams, #{Player.count} players (#{Player.where(team_id: nil).count} free agents), and #{Game.count} games."