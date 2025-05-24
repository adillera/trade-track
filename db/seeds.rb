# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

trade_logs = [
  {
    "pair" => "USD/JPY",
    "taken_at" => "2025-05-23 03:22:00", 
    "position" => "short", 
    "lot_size" => 0.90, 
    "confidence" => "high", 
    "result" => "win", 
    "amount" => 0.52,
  },
  {
    "pair" => "USD/JPY",
    "taken_at" => "2025-05-23 03:37:34", 
    "position" => "short", 
    "lot_size" => 0.90, 
    "confidence" => "high", 
    "result" => "win", 
    "amount" => 0.56,
  },
  {
    "pair" => "USD/JPY",
    "taken_at" => "2025-05-23 07:14:57", 
    "position" => "short", 
    "lot_size" => 0.90, 
    "confidence" => "high", 
    "result" => "win", 
    "amount" => 0.21,
  },
  {
    "pair" => "USD/JPY",
    "taken_at" => "2025-05-23 07:15:43", 
    "position" => "short", 
    "lot_size" => 0.90, 
    "confidence" => "high", 
    "result" => "win", 
    "amount" => 0.17,
  },
  {
    "pair" => "USD/JPY",
    "taken_at" => "2025-05-23 11:00:22", 
    "position" => "short", 
    "lot_size" => 0.82, 
    "confidence" => "high", 
    "result" => "win", 
    "amount" => 0.06,
  },
  {
    "pair" => "USD/JPY",
    "taken_at" => "2025-05-23 12:31:26", 
    "position" => "short", 
    "lot_size" => 0.90, 
    "confidence" => "high", 
    "result" => "win", 
    "amount" => 0.91,
  },
  {
    "pair" => "AUD/USD",
    "taken_at" => "2025-05-23 13:08:21", 
    "position" => "long", 
    "lot_size" => 1.90, 
    "confidence" => "high", 
    "result" => "win", 
    "amount" => 0.44,
  },
  {
    "pair" => "AUD/USD",
    "taken_at" => "2025-05-23 14:46:07", 
    "position" => "long", 
    "lot_size" => 1.90, 
    "confidence" => "high", 
    "result" => "loss", 
    "amount" => -2.28,
  },
  {
    "pair" => "AUD/USD",
    "taken_at" => "2025-05-23 14:53:02", 
    "position" => "sell", 
    "lot_size" => 1.90, 
    "confidence" => "high", 
    "result" => "win", 
    "amount" => 0.99,
  },
  {
    "pair" => "AUD/USD",
    "taken_at" => "2025-05-23 15:08:00", 
    "position" => "buy", 
    "lot_size" => 1.90, 
    "confidence" => "high", 
    "result" => "win", 
    "amount" => 0.28,
  },
  {
    "pair" => "AUD/USD",
    "taken_at" => "2025-05-23 15:38:58", 
    "position" => "buy", 
    "lot_size" => 1.27, 
    "confidence" => "high", 
    "result" => "win", 
    "amount" => 1.18,
  },
  {
    "pair" => "AUD/USD",
    "taken_at" => "2025-05-23 16:45:14", 
    "position" => "sell", 
    "lot_size" => 1.27, 
    "confidence" => "low", 
    "result" => "loss", 
    "amount" => -0.24,
  },
  {
    "pair" => "AUD/USD",
    "taken_at" => "2025-05-23 16:45:51", 
    "position" => "sell", 
    "lot_size" => 1.27, 
    "confidence" => "low", 
    "result" => "loss", 
    "amount" => -0.01,
  },
  {
    "pair" => "USD/JPY",
    "taken_at" => "2025-05-23 17:23:01", 
    "position" => "sell", 
    "lot_size" => 1.27, 
    "confidence" => "high", 
    "result" => "win", 
    "amount" => 1.54,
  },
]

trade_logs.each do |trade_log|
  Trade.find_or_create_by!(trade_log)
end