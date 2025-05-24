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

ActiveRecord::Schema[8.0].define(version: 2025_05_24_080248) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "confidence_level", ["high", "medium", "low"]
  create_enum "trade_result", ["win", "loss", "break_even"]

  create_table "trades", force: :cascade do |t|
    t.string "pair"
    t.datetime "taken_at"
    t.string "position"
    t.decimal "lot_size"
    t.enum "confidence", enum_type: "confidence_level"
    t.enum "result", enum_type: "trade_result"
    t.decimal "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "profit_counter", precision: 10, scale: 2, default: "0.0"
    t.decimal "win_rate_counter", precision: 5, scale: 4, default: "0.0"
    t.decimal "loss_rate_counter", precision: 5, scale: 4, default: "0.0"
  end
end
