# frozen_string_literal: true

class VendingMachine
  attr_accessor :drink_stocks

  def initialize
    @drink_stocks = [{ price: 120, name: 'コーラ', stock: 5 }]
  end

  def first_drink_stocks
    @drink_stocks.first
  end
end
