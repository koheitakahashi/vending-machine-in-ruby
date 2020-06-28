# frozen_string_literal: true

require 'minitest/autorun'
require './lib/vending_machine'
require './lib/suica'

class VendingMachineTest < Minitest::Test
  # TODO 共通化できるところは共通化すること

  def test_step_1_格納されている1種類のジュースの値段と名前と在庫を取得できる
    machine = VendingMachine.new
    actual = machine.select_drink("コーラ")

    assert_equal "コーラ", actual.name
  end

  # 以下、step2以降の要求仕様も同様にTDDで自動販売機プログラムを書いていく
  def test_step_2_自動販売機は在庫の点で、コーラが購入できるかどうかを取得できる。
    user = User.new(26, :man)
    suica = Suica.new
    suica.save_user(user)
    suica.charge(120)

    machine = VendingMachine.new

    5.times do
      machine.buy(suica, "コーラ")
    end

    assert_nil nil, machine.select_drink("コーラ")
  end

  def test_step_2_チャージ残高が足りない場合、購入操作を行っても何もしない。
    user = User.new(26, :man)
    suica = Suica.new
    suica.save_user(user)
    suica.charge(0)

    machine = VendingMachine.new

    assert_nil machine.buy(suica, "コーラ")
  end

  def test_step_2_在庫がない場合、購入操作を行っても何もしない。
    user = User.new(26, :man)
    suica = Suica.new
    suica.save_user(user)
    suica.charge(120)

    machine = VendingMachine.new

    5.times do
      machine.buy(suica, "コーラ")
    end

    assert_nil machine.buy(suica, "コーラ")
  end

  def test_step_2_ジュース値段以上のチャージ残高がある条件下で購入すると、自動販売機はジュースの在庫を減らし、売り上げ金額を増やし、Suicaのチャージ残高を減らす。
    user = User.new(26, :man)
    suica = Suica.new
    suica.save_user(user)
    suica.charge(120)

    machine = VendingMachine.new
    machine.buy(suica, "コーラ")

    assert_equal(0, suica.deposit)
    assert_equal(4, machine.show_stock("コーラ"))
    assert_equal(120, machine.sales_amount)
  end

  def test_step_3_レッドブルを購入することができる
    user = User.new(26, :man)
    suica = Suica.new
    suica.save_user(user)
    suica.charge(200)

    machine = VendingMachine.new
    machine.buy(suica, "レッドブル")

    assert_equal(0, suica.deposit)
    assert_equal(4, machine.show_stock("レッドブル"))
    assert_equal(200, machine.sales_amount)
  end

  def test_step_3_水を購入することができる
    user = User.new(26, :man)
    suica = Suica.new
    suica.save_user(user)
    suica.charge(100)

    machine = VendingMachine.new
    machine.buy(suica, "水")

    assert_equal(0, suica.deposit)
    assert_equal(4, machine.show_stock("水"))
    assert_equal(100, machine.sales_amount)
  end

  def test_step_5_ジュースが購入されたタイミングで、販売日時とSuica利用者の年齢と性別を記録する
    user = User.new(26, :man)
    suica = Suica.new
    suica.save_user(user)
    suica.charge(100)

    machine = VendingMachine.new
    machine.buy(suica, "水")
    machine.show_sales_history(1).first[:sales_time] = Time.new(2020)

    expected = [{
      sales_time: Time.new(2020),
      user: user
    }]

    assert_equal expected, machine.show_sales_history(1)
    assert_equal 26, machine.show_sales_history(1).first[:user].age
    assert_equal :man, machine.show_sales_history(1).first[:user].sex
  end
end
