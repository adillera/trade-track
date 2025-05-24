class CreateTrades < ActiveRecord::Migration[8.0]
  def change
    create_table :trades do |t|
      t.string :pair
      t.datetime :taken_at
      t.string :position
      t.decimal :lot_size
      t.string :confidence
      t.string :result
      t.decimal :amount
      t.decimal :profit
      t.decimal :win_rate
      t.decimal :loss_rate
      t.decimal :profit_factor

      t.timestamps
    end
  end
end
