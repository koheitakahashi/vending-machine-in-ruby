# frozen_string_literal: true

require 'minitest/autorun'
require './lib/vending_machine'

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

  def test_step_1_格納されている1種類のジュースの値段と名前と在庫を取得できる
    machine = VendingMachine.new
    expected = { price: 120, name: "コーラ", stock: 5 }

    assert_equal expected, machine.drink_info
  end

  # 以下、step2以降の要求仕様も同様にTDDで自動販売機プログラムを書いていく
end
