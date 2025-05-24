class TradesController < ApplicationController
  def create
    @trade = Trade.new(trade_params)

    if @trade.save
      @trade = Trade.new
      @metrics = Trade.metrics
    end
  end

  private

  def trade_params
    params.expect(trade: [:taken_at, :position, :lot_size, :confidence, :result])
  end
end
