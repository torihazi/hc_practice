# frozen_string_literal: true

require_relative('vendor')

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
puts '自動販売機は在庫の一覧を取得できる'
puts vendor.stock_info_list

puts
puts 'ステップ3'
puts '自動販売機はペプシが購入できるか取得できる'
puts vendor.buyable?(suica)
puts '自動販売機は指定条件のもとで購入が可能'
puts vendor.stock_info_list
vendor.buy(suica, 'ペプシ', 2)
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
vendor.replenish('いろはす', 2)
puts vendor.stock_info_list
puts 'モンスターといろはすを1本ずつ購入 => 1000円チャージして実行'
suica.top_up(1000)
puts suica.balance
puts vendor.stock_info_list
puts '購入'
vendor.buy(suica, 'モンスター', 1)
vendor.buy(suica, 'いろはす', 1)
puts vendor.stock_info_list
puts "残高: #{suica.balance}, 売上: #{vendor.sales_amount}"
