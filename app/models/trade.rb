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
      profit_factor: calculate_profit_factor,
      high_confidence_win_rate: calculate_confidence_win_rate('high'),
      medium_confidence_win_rate: calculate_confidence_win_rate('medium'),
      low_confidence_win_rate: calculate_confidence_win_rate('low'),
      best_performing_pair: calculate_best_performing_pair
    }
  end

  private

  def self.calculate_profit_factor
    winning_profits = where(result: "win").sum(:profit_counter)
    losing_profits = where(result: "loss").sum(:profit_counter).abs
    losing_profits.positive? ? (winning_profits / losing_profits) : 0
  end

  def self.calculate_confidence_win_rate(confidence_level)
    confidence_trades = where(confidence: confidence_level)
    return 0 if confidence_trades.empty?

    confidence_wins = confidence_trades.where(result: 'win').count
    confidence_wins.to_f / confidence_trades.count
  end

  def self.calculate_best_performing_pair
    pairs = select(:pair)
           .group(:pair)
           .having('count(*) >= 3') # Only consider pairs with at least 3 trades
           .pluck(:pair)

    return { pair: 'N/A', win_rate: 0 } if pairs.empty?

    best_pair = pairs.max_by do |pair|
      pair_trades = where(pair: pair)
      pair_wins = pair_trades.where(result: 'win').count
      pair_wins.to_f / pair_trades.count
    end

    pair_trades = where(pair: best_pair)
    pair_wins = pair_trades.where(result: 'win').count
    win_rate = pair_wins.to_f / pair_trades.count

    {
      pair: best_pair,
      win_rate: win_rate,
      total_trades: pair_trades.count
    }
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
