class DashboardController < ApplicationController
  def show
    @trade = Trade.new
    @metrics = Trade.metrics 
  end
end
