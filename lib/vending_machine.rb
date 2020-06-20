# frozen_string_literal: true

class VendingMachine
  attr_accessor :drink_stocks, :sales_amount, :drink

  def initialize
    @drink_stocks = [
      { price: 100, name: '水', stock: 5 },
      { price: 120, name: 'コーラ', stock: 5 },
      { price: 200, name: 'レッドブル', stock: 5 }
    ]
    @drink = nil
    @sales_amount = 0
  end

  def first_drink_stocks
    @drink_stocks.first
  end

  def can_purchase?
    first_drink_stocks[:stock] > 0
  end

  def purchase(suica, str)
    return "チャージ残高が足りません" if suica.deposit < first_drink_stocks[:price]
    return "在庫がありません" unless display_purchasable_list.include?(str)

    purchasable_list.each do |drink|
      @drink = drink if drink[:name] === str
    end

    suica.deposit -= @drink[:price]
    @drink[:stock] -= 1
    @sales_amount += @drink[:price]
  end

  def purchasable_list
    @drink_stocks.map { |drink| drink if drink[:stock] > 1 }
  end

  def display_purchasable_list
    purchasable_list.map { |drink| drink[:name] }
  end
end
