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

  def can_purchase?(str)
    find_drink(str)[:stock] > 0
  end

  def purchase(suica, str)
    find_drink(str)

    return "チャージ残高が足りません" if suica.deposit < @drink[:price]
    return "在庫がありません" if @drink[:stock] === 0

    suica.deposit -= @drink[:price]
    @drink[:stock] -= 1
    @sales_amount += @drink[:price]
  end

  def find_drink(str)
    purchasable_list.each do |drink|
      @drink = drink if drink[:name] === str
    end
    @drink
  end

  def purchasable_list
    @drink_stocks.map do |drink|
      if drink[:stock] > 0
        drink
      else
        { price: nil, name: nil, stock: nil }
      end
    end
  end

  def display_purchasable_list
    purchasable_list.map { |drink| drink[:name] }
  end
end
