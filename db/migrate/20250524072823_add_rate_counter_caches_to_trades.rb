class AddRateCounterCachesToTrades < ActiveRecord::Migration[8.0]
  def change
    add_column :trades, :win_rate_counter, :decimal, precision: 5, scale: 4, default: 0
    add_column :trades, :loss_rate_counter, :decimal, precision: 5, scale: 4, default: 0

    # Initialize the counter caches for existing records
    reversible do |dir|
      dir.up do
        total_trades = execute("SELECT COUNT(*) FROM trades").first["count"].to_f
        if total_trades.positive?
          win_rate = execute("SELECT COUNT(*) FROM trades WHERE result = 'win'").first["count"].to_f / total_trades
          loss_rate = execute("SELECT COUNT(*) FROM trades WHERE result = 'loss'").first["count"].to_f / total_trades
          
          execute <<-SQL
            UPDATE trades 
            SET win_rate_counter = #{win_rate},
                loss_rate_counter = #{loss_rate}
          SQL
        end
      end
    end
  end
end
