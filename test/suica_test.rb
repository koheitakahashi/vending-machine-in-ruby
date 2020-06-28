# frozen_string_literal: true

require 'minitest/autorun'
require './lib/suica'

class SuicaTest < Minitest::Test
  def setup
    @suica = Suica.new
  end

  def test_step_0_Suicaには100円以上の金額をチャージできる
    assert_equal(0, @suica.charge(10))
    assert_equal 100, @suica.charge(100)
  end

  def test_step_0_金額をチャージしたときチャージ残高を取得できる
    assert_equal(0, @suica.deposit)
  end

  def test_step_0_金額をチャージしたときチャージ残高を取得できる
    @suica.charge(200)

    assert_equal(200, @suica.deposit)
  end

  def test_step_4_利用者の年齢と性別を保存できる
    user = User.new(26, 'man')
    @suica.save_user(user)

    assert_equal(26, @suica.user.age)
    assert_equal('man', @suica.user.sex)
  end
end
