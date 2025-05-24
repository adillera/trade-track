class Trade < ApplicationRecord
  before_save :update_profit_counter
  after_save :update_rate_counters

  enum :confidence, {
    high: 'high',
    medium: 'medium',
    low: 'low'
  }, prefix: true

  enum :result, {
    win: 'win',
    loss: 'loss',
    break_even: 'break_even'
  }, prefix: true

  enum :position, {
    long: 'long',
    short: 'short'
  }, prefix: true

  def self.metrics
    total = count
    latest_trade = order(created_at: :desc).first
    
    {
      total_trades: total,
      win_rate: latest_trade&.win_rate_counter || 0,
      total_profit: latest_trade&.profit_counter || 0,
      profit_factor: calculate_profit_factor,
      high_confidence_win_rate: calculate_confidence_win_rate('high'),
      medium_confidence_win_rate: calculate_confidence_win_rate('medium'),
      low_confidence_win_rate: calculate_confidence_win_rate('low'),
      top_performing_pairs: calculate_top_performing_pairs
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

  def self.calculate_position_win_rate(position_type)
    position_trades = where(position: position_type)
    return 0 if position_trades.empty?

    position_wins = position_trades.where(result: 'win').count
    position_wins.to_f / position_trades.count
  end

  def self.calculate_top_performing_pairs
    pairs = select(:pair)
           .group(:pair)
           .having('count(*) >= 3') # Only consider pairs with at least 3 trades
           .pluck(:pair)

    return [{ pair: 'N/A', win_rate: 0, total_trades: 0 }] if pairs.empty?

    pairs_with_stats = pairs.map do |pair|
      pair_trades = where(pair: pair)
      pair_wins = pair_trades.where(result: 'win').count
      win_rate = pair_wins.to_f / pair_trades.count

      {
        pair: pair,
        win_rate: win_rate,
        total_trades: pair_trades.count
      }
    end

    # Sort by win rate in descending order and take top 3
    pairs_with_stats.sort_by { |stats| -stats[:win_rate] }.first(3)
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
