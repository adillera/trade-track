class Trade < ApplicationRecord
  before_save :update_profit_counter
  after_save :update_rate_counters

  def self.metrics
    total = count
    wins = where(result: "win").count
    losses = where(result: "loss").count
    total_profit = sum(:profit)
    winning_profits = where(result: "win").sum(:profit)
    losing_profits = where(result: "loss").sum(:profit).abs
    
    {
      total_trades: total,
      win_rate: total.positive? ? (wins.to_f / total) : 0,
      loss_rate: total.positive? ? (losses.to_f / total) : 0,
      total_profit: total_profit,
      profit_factor: losing_profits.positive? ? (winning_profits / losing_profits) : 0
    }
  end

  private

  def update_profit_counter
    self.profit_counter = if result == 'win'
                           amount
                         elsif result == 'loss'
                           -amount
                         else
                           0
                         end
  end

  def update_rate_counters
    total = self.class.count.to_f
    return if total.zero?

    win_rate = self.class.where(result: 'win').count.to_f / total
    loss_rate = self.class.where(result: 'loss').count.to_f / total

    self.class.update_all(
      win_rate_counter: win_rate,
      loss_rate_counter: loss_rate
    )
  end
end
