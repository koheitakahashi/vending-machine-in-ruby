# frozen_string_literal: true

require 'minitest/autorun'
require './lib/vending_machine'
require './lib/suica'

class VendingMachineTest < Minitest::Test
  # def test_step_1_ジュースの管理
  #   # 以下の2行は動作確認用のコードなので削除して良い
  #   machine = VendingMachine.new
  #   assert !machine.nil?
  #
  #   # 以下の要求仕様（テストケース）は必要に応じてテストメソッド（def test_xxx）を分けても良い
  #   #
  #   # 自動販売機は値段と名前の属性からなるジュースを１種類格納できる。初期状態で、コーラ（値段:120円、名前”コーラ”）を5本格納している。
  #   # 自動販売機は格納されているジュースの情報（値段と名前と在庫）を取得できる。
  # end

  # TODO 共通化できるところは共通化すること

  def test_step_1_格納されている1種類のジュースの値段と名前と在庫を取得できる
    machine = VendingMachine.new
    actual = machine.find_drink("コーラ").name

    assert_equal "コーラ", actual
  end

  # 以下、step2以降の要求仕様も同様にTDDで自動販売機プログラムを書いていく
  def test_step_2_自動販売機は在庫の点で、コーラが購入できるかどうかを取得できる。
    suica = Suica.new
    suica.store_user(26, :man)
    suica.charge(120)

    machine = VendingMachine.new
    machine.find_drink("コーラ").stock = 0

    assert_equal false, machine.can_purchase?("コーラ")
  end

  def test_step_2_チャージ残高が足りない場合、購入操作を行っても何もしない。
    suica = Suica.new
    suica.store_user(26, :man)
    suica.charge(0)

    machine = VendingMachine.new

    assert_equal("チャージ残高が足りません", machine.purchase(suica, "コーラ"))
  end

  def test_step_2_在庫がない場合、購入操作を行っても何もしない。
    suica = Suica.new
    suica.store_user(26, :man)
    suica.charge(120)

    machine = VendingMachine.new
    machine.find_drink("コーラ").stock = 0

    assert_equal("在庫がありません", machine.purchase(suica, "コーラ"))
  end

  def test_step_2_ジュース値段以上のチャージ残高がある条件下で購入すると、自動販売機はジュースの在庫を減らし、売り上げ金額を増やし、Suicaのチャージ残高を減らす。
    suica = Suica.new
    suica.store_user(26, :man)
    suica.charge(120)

    machine = VendingMachine.new
    machine.purchase(suica, "コーラ")

    assert_equal(0, suica.deposit)
    assert_equal(4, machine.find_drink("コーラ").stock)
    assert_equal(120, machine.sales_amount)
  end

  def test_step_3_自動販売機は在庫の点で購入可能なドリンクのリストを取得できる。
    machine = VendingMachine.new
    expected = ["水", "コーラ", "レッドブル"]

    assert_equal expected, machine.purchasable_name_list
  end

  def test_step_3_レッドブルを購入することができる
    suica = Suica.new
    suica.store_user(26, :man)
    suica.charge(200)

    machine = VendingMachine.new
    machine.purchase(suica, "レッドブル")

    assert_equal(0, suica.deposit)
    assert_equal(4, machine.find_drink("レッドブル").stock)
    assert_equal(200, machine.sales_amount)
  end

  def test_step_3_水を購入することができる
    suica = Suica.new
    suica.store_user(26, :man)
    suica.charge(100)

    machine = VendingMachine.new
    machine.purchase(suica, "水")

    assert_equal(0, suica.deposit)
    assert_equal(4, machine.find_drink("水").stock)
    assert_equal(100, machine.sales_amount)
  end

  def test_step_5_ジュースが購入されたタイミングで、販売日時とSuica利用者の年齢と性別を記録する
    suica = Suica.new
    suica.store_user(26, :man)
    suica.charge(100)

    # TODO purchaseというメソッド名をbuyにする
    machine = VendingMachine.new
    machine.purchase(suica, "水")

    expected = { sales_time: Time.new(2020), user_age: 26, user_sex: :man }
    assert_equal expected, machine.history.show.first
  end
end
