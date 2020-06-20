# frozen_string_literal: true

require 'minitest/autorun'
require './lib/suica'

class SuicaTest < Minitest::Test
  # def test_step_0_Suicaのチャージ
  # 以下の要求仕様（テストケース）は必要に応じてテストメソッド（def test_xxx）を分けても良い
  #
  # Suicaには100円以上の任意の金額をチャージできる
  # Suicaは現在のチャージ残高を取得できる。
  # end

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
  # 以下、step1以降の要求仕様も同様にTDDで自動販売機プログラムを書いていく
end
