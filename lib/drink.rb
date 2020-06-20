# frozen_string_literal: true

class Drink
  attr_accessor :price, :name, :stock

  def initialize(price: , name: , stock: 5)
    @price = price
    @name = name
    @stock = stock
  end
end
