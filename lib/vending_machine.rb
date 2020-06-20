# frozen_string_literal: true

class VendingMachine
  attr_accessor :drink_stocks, :sales_amount

  def initialize
    @drink_stocks = [{ price: 120, name: 'コーラ', stock: 5 }]
    @sales_amount = 0
  end

  def first_drink_stocks
    @drink_stocks.first
  end

  def can_purchase?
    first_drink_stocks[:stock] > 0
  end

  def purchase(suica)
    return "チャージ残高が足りません" if suica.deposit < first_drink_stocks[:price]
    return "在庫がありません" unless can_purchase?

    suica.deposit -= first_drink_stocks[:price]
    first_drink_stocks[:stock] -= 1
    @sales_amount += first_drink_stocks[:price]
  end
end
