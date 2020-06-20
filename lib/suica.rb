# frozen_string_literal: true

class Suica
  attr_accessor :deposit

  def initialize
    @deposit = 0
  end

  def charge(amount)
    @deposit += amount if amount >= 100
    @deposit
  end
end
