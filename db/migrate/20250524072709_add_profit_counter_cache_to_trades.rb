class AddProfitCounterCacheToTrades < ActiveRecord::Migration[8.0]
  def change
    add_column :trades, :profit_counter, :decimal, precision: 10, scale: 2, default: 0

    # Initialize the counter cache for existing records
    reversible do |dir|
      dir.up do
        execute <<-SQL
          UPDATE trades 
          SET profit_counter = amount 
          WHERE result = 'win'
        SQL
        execute <<-SQL
          UPDATE trades 
          SET profit_counter = -amount 
          WHERE result = 'loss'
        SQL
      end
    end
  end
end
