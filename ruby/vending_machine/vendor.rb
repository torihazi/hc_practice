# frozen_string_literal: true

require_relative 'bevarage'
require_relative 'suica'

# クラス名 Vendor
# @param [Hash] stocks 商品情報と数量
# @param [Integer] sales_amount 売上金額
class Vendor
  def initialize
    @stocks = {}
    @sales_amount = 0
    store(Bevarage.new(:pepsi, 150), 5)
    store(Bevarage.new(:monster, 230), 5)
    store(Bevarage.new(:irohasu, 120), 5)
  end

  # stocks ゲッターメソッド(在庫の取得)
  def stocks
    @stocks
  end

  # sales ゲッターメソッド
  def sales_amount
    @sales_amount
  end

  # sales セッターメソッド
  private def sales_amount=(money)
    @sales_amount = money
  end

  # stocks セッターメソッド
  private def stocks=(value)
    @stocks = value
  end

  # 商品を格納する
  def store(bevarage, num)
    @stocks[bevarage.name] = {
      price: bevarage.price,
      stock: num
    }
  end

  # 在庫の取得
  def list_of_stock
    @stocks.map { |k, v| "名前: #{k}, 在庫: #{v[:stock]}" }
  end

  # ペプシを購入できるか
  # def buy_pepsi?(suica)
  #   @stocks[:pepsi][:stock].positive? && suica.balance >= @stocks[:pepsi][:price]
  # end

  # 飲み物を購入できるか
  def buy?(suica, bevarage_name, num =1)
    @stocks[bevarage_name][:stock] >= num && suica.balance >= @stocks[bevarage_name][:price] * num
  end

  # 購入できる飲み物の一覧
  def list_of_buyable_bevarages(suica)
    @stocks.select { |k, _| buy?(suica, k) }.keys
  end

  # 購入
  def buy(suica, bevarage_name, num = 1)
    if buy?(suica, bevarage_name, num)
      @stocks[bevarage_name][:stock] -= num
      @sales_amount += @stocks[bevarage_name][:price] * num
      suica.balance -= @stocks[bevarage_name][:price] * num
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

  # 補充する
  def replenish(bevarage_name, num)
    if @stocks.key?(bevarage_name) && num.positive?
      @stocks[bevarage_name][:stock] += num
    else
      raise '存在しない商品です。'
    end
  end
end


vendor = Vendor.new
suica = Suica.new

puts 
puts "ステップ1"
puts "suicaのチャージ残高を確認(初期値は500円)"
puts suica.balance

puts "100円以上の任意の額をチャージ (200円チャージ)"
suica.top_up(200)
puts suica.balance

# puts "100円未満であれば例外"
# puts suica.top_up(20)

puts
puts "ステップ2"
puts "自動販売機は在庫を取得できる"
puts vendor.list_of_stock

puts
puts "ステップ3"
puts "自動販売機はペプシが購入できるか取得できる"
puts vendor.buy?(suica, :pepsi)
puts "自動販売機は指定条件のもとで購入が可能"
puts vendor.list_of_stock
vendor.buy(suica, :pepsi,2)
puts "ペプシを2本購入"
puts vendor.list_of_stock
# puts "購入金額が足りないもしくは在庫がない場合は例外"
# puts "ペプシを5本購入(残高不足)"
# vendor.buy(suica, :pepsi, 5)
# puts "ペプシを6本購入(在庫不足) ペプシの初期在庫を 3本に設定"
# vendor.buy(suica, :pepsi, 6)
puts "自動販売機は現在の売上金額を取得できる"
puts vendor.sales_amount

puts
puts "ステップ4"
# puts "ジュースを3種類格納できる => すでに実施済み"
puts "自動販売機は購入可能なドリンクのリストを取得できる"
puts vendor.list_of_buyable_bevarages(suica)
puts "自動販売機は在庫を補充できる(irohasuを2本補充)"
vendor.replenish(:irohasu, 2)
puts vendor.list_of_stock
puts "モンスターといろはすを1本ずつ購入 => 1000円チャージして実行"
suica.top_up(1000)
puts suica.balance
puts vendor.list_of_stock
puts "購入"
vendor.buy(suica, :monster, 1)
vendor.buy(suica, :irohasu, 1)
puts vendor.list_of_stock
puts "残高: #{suica.balance}, 売上: #{vendor.sales_amount}"