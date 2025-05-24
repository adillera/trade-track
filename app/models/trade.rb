class Trade < ApplicationRecord
  before_save :update_profit_counter
  after_save :update_rate_counters

  def self.metrics
    total = count
    latest_trade = order(created_at: :desc).first
    
    {
      total_trades: total,
      win_rate: latest_trade&.win_rate_counter || 0,
      loss_rate: latest_trade&.loss_rate_counter || 0,
      total_profit: latest_trade&.profit_counter || 0,
      profit_factor: calculate_profit_factor
    }
  end

  private

  def self.calculate_profit_factor
    winning_profits = where(result: "win").sum(:profit_counter)
    losing_profits = where(result: "loss").sum(:profit_counter).abs
    losing_profits.positive? ? (winning_profits / losing_profits) : 0
  end

  def update_profit_counter
    previous_total = self.class.order(created_at: :desc).first&.profit_counter || 0
    
    self.profit_counter = previous_total + amount
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
