class DashboardController < ApplicationController
  def show
    @trade = Trade.new
  end
end
