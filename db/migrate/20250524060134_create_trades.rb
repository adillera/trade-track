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

      t.timestamps
    end
  end
end
