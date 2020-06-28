# frozen_string_literal: true

require 'drink'

class VendingMachine
  attr_accessor :drink_stocks, :sales_amount

  def initialize
    @drink_stocks = []
    @selected_drink = nil
    @sales_amount = 0
    @sales_history_list = []
    fill_in_stock
  end

  # TODO カプセル化すること
  def buy(suica, drink_name)
    @selected_drink = select_drink(drink_name)

    return nil if suica.deposit < @selected_drink.price

    if select_drink_index(drink_name).nil?
      return nil
    else
      @drink_stocks.delete_at(select_drink_index(drink_name))
      suica.deposit -= @selected_drink.price
      @sales_amount += @selected_drink.price
      save_sales_history(Time.now, suica.user)
    end
  end

  def select_drink(drink_name)
    @drink_stocks.fetch(select_drink_index(drink_name))
  end

  def show_stock(drink_name)
    @drink_stocks.select { |drink| drink.name === drink_name }.count
  end

  def purchasable_list
    @drink_stocks.map { |drink| drink }.uniq
  end

  def show_sales_history(num)
    @sales_history_list.take(num)
  end

  private
    def fill_in_stock
      5.times do
        @drink_stocks << Drink.new(100, "水")
        @drink_stocks << Drink.new(120, "コーラ")
        @drink_stocks << Drink.new(200, "レッドブル")
      end
    end

    def select_drink_index(drink_name)
      @drink_stocks.index do |drink|
        drink.name === drink_name
      end
    end

    def save_sales_history(sales_time, user)
      @sales_history_list << { sales_time: sales_time, user: { age: user.age, sex: user.sex } }
    end
end
