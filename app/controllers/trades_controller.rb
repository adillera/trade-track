class TradesController < ApplicationController
  def create
    @trade = Trade.new(trade_params)

    if @trade.save
      @trade = Trade.new
      render turbo_stream: turbo_stream.replace("trade_form", partial: "trades/form", locals: { trade: @trade })
    else
      render turbo_stream: turbo_stream.replace("trade_form", partial: "trades/form", locals: { trade: @trade })
    end
  end

  private

  def trade_params
    params.expect(trade: [:taken_at, :position, :lot_size, :confidence, :result])
  end
end
