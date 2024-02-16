# frozen_string_literal: true

require_relative 'bevarage'
require_relative 'suica'

# クラス名 Vendor
# @param [Hash] stocks 商品情報と数量
# @param [Integer] sales_amount 売上金額
class Vendor
  attr_reader :stocks, :sales_amount

  def initialize
    @stocks = []
    @sales_amount = 0
    5.times do
      @stocks << Bevarage.new('ペプシ', 150)
      @stocks << Bevarage.new('モンスター', 230)
      @stocks << Bevarage.new('いろはす', 120)
    end
  end

  # 指定した名前の飲み物情報一覧
  def bevarage_info(bevarage_name = 'ペプシ')
    @stocks.select { |k| k.name.eql?(bevarage_name) }
  end

  # 在庫の取得
  def stock_info(bevarage_name = 'ペプシ')
    quantity = bevarage_info(bevarage_name).size
    "名前: #{bevarage_name} 在庫数: #{quantity}"
  end

  # 在庫一覧の取得
  def stock_info_list
    beverage_name_list = @stocks.map { |k| k.name }.uniq
    beverage_name_list.map { |k| stock_info(k) }
  end

  # 飲み物を購入できるか
  def buyable?(suica, bevarage_name = 'ペプシ', want_num = 1)
    info = bevarage_info(bevarage_name)
    info.any? && suica.balance >= info.first.price * want_num
  end

  # 1本購入できる飲み物の一覧
  def list_of_buyable_bevarages(suica)
    beverage_name_list = @stocks.map { |k| k.name }.uniq
    beverage_name_list.select { |k| buyable?(suica, k) }
  end

  # 購入
  def buy(suica, bevarage_name = 'ペプシ', want_num = 1)
    raise '残高不足か在庫切れです' unless buyable?(suica, bevarage_name, want_num)

    items = @stocks.select { |k| k.name.eql?(bevarage_name) }.first(want_num)
    items.each do |v|
      @stocks.delete_if { |k| k.object_id.eql?(v.object_id) }
    end
    @sales_amount += items[0].price * want_num
    suica.balance -= items[0].price * want_num
  end

  # 補充する => すでにあるものしか補充できないとしました。
  def replenish(bevarage_name = 'ペプシ', num = 1)
    raise '存在しない商品です。' unless @stocks.any? { |k| k.name.eql?(bevarage_name) } && num.positive?

    num.times { @stocks << @stocks.find { |k| k.name.eql?(bevarage_name) }.dup }
  end
end
