class Trade < ApplicationRecord
  def self.metrics
    {
      total_trades: count,
      win_rate: where(result: "win").count / count.to_f,
      average_profit_factor: where(result: "win").average(:profit_factor),
      average_win_rate: where(result: "win").average(:win_rate),
      average_loss_rate: where(result: "loss").average(:loss_rate),
    }
  end
end
