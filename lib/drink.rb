# frozen_string_literal: true

class Drink
  attr_accessor :price, :name, :stock

  def initialize(price, name)
    @price = price
    @name = name
  end
end
