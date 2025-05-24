class Trade < ApplicationRecord
  def self.metrics
    total = count
    wins = where(result: "win").count
    losses = where(result: "loss").count
    
    {
      total_trades: total,
      win_rate: total.positive? ? (wins.to_f / total) : 0,
    }
  end
end
