require 'minitest/autorun'
require './lib/suica'

class SuicaTest < Minitest::Test
  def test_step_0_Suicaのチャージ
    # 以下の2行は動作確認用のコードなので削除して良い
    suica = Suica.new
    assert !suica.nil?

    # 以下の要求仕様（テストケース）は必要に応じてテストメソッド（def test_xxx）を分けても良い
    #
    # Suicaには100円以上の任意の金額をチャージできる
    # Suicaは現在のチャージ残高を取得できる。
  end

  # 以下、step1以降の要求仕様も同様にTDDで自動販売機プログラムを書いていく
end
