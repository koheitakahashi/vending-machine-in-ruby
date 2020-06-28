# frozen_string_literal: true

class User
  attr_accessor :age, :sex

  def initialize(age, sex)
    @age = age
    @sex = sex
  end
end
