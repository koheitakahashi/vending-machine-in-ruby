# frozen_string_literal: true

require "user"

class Suica
  attr_accessor :deposit, :user

  def initialize
    @deposit = 0
    @user = nil
  end

  def charge(amount)
    @deposit += amount if amount >= 100
    @deposit
  end

  def store_user(age, sex)
    @user = User.new(age, sex)
  end
end
