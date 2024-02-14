# frozen_string_literal: true

require_relative 'bevarage'
require_relative 'suica'

# クラス名 Vendor
# @param [Hash] stocks 商品情報と数量
# @param [Integer] sales_amount 売上金額
class Vendor
  attr_reader :stocks, :sales_amount
  attr_writer :stocks, :sales_amount

  def initialize
    @stocks = []
    @sales_amount = 0
    5.times { @stocks << Bevarage.new('ペプシ', 150) }
    5.times { @stocks << Bevarage.new('モンスター', 230) }
    5.times { @stocks << Bevarage.new('いろはす', 120) }
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

  # ペプシを購入できるか
  # def buy_pepsi?(suica, bevarage_name = 'ペプシ', want_num = 1)
  #   info = bevarage_info(bevarage_name)
  #   info.any? && suica.balance >= info.first.price * want_num
  # end

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
    if buyable?(suica, bevarage_name, want_num)
      item = @stocks.find { |k| k.name.eql?(bevarage_name) }
      @stocks.delete_if { |k| k.object_id.eql?(item.object_id) }
      @sales_amount += item.price * want_num
      suica.balance -= item.price * want_num
    else
      raise '残高不足か在庫切れです'
    end
  end
  # def buy_pepsi(suica)
  #   if buy_pepsi?(suica)
  #     price = @stocks[:pepsi][:price]
  #     @stocks[:pepsi][:stock] -= 1
  #     @sales_amount += price
  #     suica.balance += price
  #   else
  #     raise '残高不足もしくは在庫切れです'
  #   end
  # end

  # 補充する => すでにあるものしか補充できないとしました。
  def replenish(bevarage_name = 'ペプシ', num = 1)
    if @stocks.any? { |k| k.name.eql?(bevarage_name) } && num.positive?
      num.times { @stocks << @stocks.find { |k| k.name.eql?(bevarage_name) }.dup }
    else
      raise '存在しない商品です。'
    end
  end
end


vendor = Vendor.new
suica = Suica.new

puts 
puts 'ステップ1'
puts 'suicaのチャージ残高を確認(初期値は500円)'
puts suica.balance

puts '100円以上の任意の額をチャージ (200円チャージ)'
suica.top_up(200)
puts suica.balance

# puts '100円未満であれば例外'
# puts suica.top_up(20)

puts
puts 'ステップ2'
puts '自動販売機は在庫を取得できる'
puts vendor.stock_info
puts vendor.stock_info_list

puts
puts 'ステップ3'
puts '自動販売機はペプシが購入できるか取得できる'
puts vendor.buyable?(suica)
puts '自動販売機は指定条件のもとで購入が可能'
puts vendor.stock_info_list
vendor.buy(suica, "ペプシ", 2)
puts 'ペプシを2本購入'
puts vendor.stock_info_list
puts '購入金額が足りないもしくは在庫がない場合は例外'
# puts 'ペプシを5本購入(残高不足)'
# vendor.buy(suica, "ペプシ", 5)
# puts 'ペプシを6本購入(在庫不足) ペプシの初期在庫を 3本に設定'
# vendor.buy(suica, "ペプシ", 6)
puts '自動販売機は現在の売上金額を取得できる'
puts vendor.sales_amount

puts
puts 'ステップ4'
# puts 'ジュースを3種類格納できる => すでに実施済み'
puts '自動販売機は購入可能なドリンクのリストを取得できる'
puts vendor.list_of_buyable_bevarages(suica)
puts '自動販売機は在庫を補充できる(irohasuを2本補充)'
vendor.replenish("いろはす", 2)
puts vendor.stock_info_list
puts 'モンスターといろはすを1本ずつ購入 => 1000円チャージして実行'
suica.top_up(1000)
puts suica.balance
puts vendor.stock_info_list
puts '購入'
vendor.buy(suica, "モンスター", 1)
puts "残高: #{suica.balance}, 売上: #{vendor.sales_amount}"
vendor.buy(suica, "いろはす", 1)
puts vendor.stock_info_list
puts "残高: #{suica.balance}, 売上: #{vendor.sales_amount}"