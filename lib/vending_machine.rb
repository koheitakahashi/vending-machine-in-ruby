# frozen_string_literal: true
require 'drink'

class VendingMachine
  attr_accessor :drink_stocks, :sales_amount

  def initialize
    @drink_stocks = [
      @water = Drink.new(price: 100, name: "水", stock: 5),
      @cola = Drink.new(price: 120, name: "コーラ", stock: 5),
      @redbull = Drink.new(price: 200, name: "レッドブル", stock: 5)
    ]
    @sales_amount = 0
    @sales_history_list = []
  end

  # TODO カプセル化すること
  def can_purchase?(str)
    find_drink(str).stock > 0
  end

  def purchase(suica, str)
    find_drink(str)

    return "チャージ残高が足りません" if suica.deposit < @selected_drink.price
    return "在庫がありません" if @selected_drink.stock === 0

    suica.deposit -= @selected_drink.price
    @selected_drink.stock -= 1
    @sales_amount += @selected_drink.price

    save_sales_history(Time.now, suica.user)
  end

  def find_drink(str)
    purchasable_list.each do |drink|
      @selected_drink = drink if drink&.name === str
    end
    @selected_drink
  end

  def purchasable_list
    @drink_stocks.map do |drink|
      drink if drink.stock > 0
    end
  end

  def purchasable_name_list
    purchasable_list.map { |drink| drink.name }
  end

  def save_sales_history(sales_time, user)
    @sales_history_list << { sales_time: sales_time, user: { age: user.age, sex: user.sex } }
  end

  def show_sales_history(num)
    @sales_history_list.take(num)
  end
end
