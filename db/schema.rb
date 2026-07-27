# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2026_07_27_143904) do
  create_table "games", force: :cascade do |t|
    t.integer "home_team_id", null: false
    t.integer "away_team_id", null: false
    t.integer "home_score", null: false
    t.integer "away_score", null: false
    t.datetime "date_played", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["away_team_id"], name: "index_games_on_away_team_id"
    t.index ["home_team_id"], name: "index_games_on_home_team_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name", null: false
    t.integer "team_id"
    t.integer "batting", null: false
    t.integer "running", null: false
    t.integer "pitching", null: false
    t.integer "fielding", null: false
    t.integer "total_skill", null: false
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.integer "team_skill", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "games", "teams", column: "away_team_id"
  add_foreign_key "games", "teams", column: "home_team_id"
  add_foreign_key "players", "teams"
end
