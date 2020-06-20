# frozen_string_literal: true

class History
  def initialize
    @list = []
  end

  def save(sales_time:, user:)
    @list << { sales_time: sales_time, user_age: user.age, user_sex: user.sex }
  end

  def show
    @list
  end
end